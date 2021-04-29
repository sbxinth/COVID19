//
//  register.swift
//  final-project
//
//  Created by Anwa on 27/4/2564 BE.
//

import UIKit
import GRDB

class register: UIViewController {
    var dbPath : String = ""
    var dbResourcePath : String = ""
    var config = Configuration()
    let fileManager = FileManager.default
    

    @IBOutlet weak var txtMemname: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtRepass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMemid: UITextField!
    
    @objc func tap(sender: UITapGestureRecognizer){
            print("tapped")
        checkTextfieldisEmpty()
            view.endEditing(true)
    }
    
    @IBAction func txtRepass(_ sender: Any) {
        if txtPass.text != txtRepass.text{
            alertWithTitle(title: "REPASSWORD ERROR!", message: "รหัสผ่านไม่ตรง")
        }
    }
    
    @IBAction func txtEmail(_ sender: Any) {
        if (txtEmail.text?.isValidEmail())! == false{
            alertWithTitle(title: "EMAIL ERROR!", message: "Email ไม่ถูกรูปแบบ!")
        }
    }
    
    @IBAction func btnRegist(_ sender: Any) {
        checkTextfieldisEmpty()
        var memid:Int = Int(txtMemid.text!)!
        
        do {
            config.readonly=false
            let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)

            try dbQueue.write {
                db in
                try db.execute(sql: "INSERT INTO register (member_id, member_name, mem_passw, email) VALUES (?, ?, ?, ?)",
                               arguments: [memid, txtMemname.text,txtPass.text,txtEmail.text])
                } //try dbQueue.write
      
            try dbQueue.write {
                db in
                        
                try db.execute(sql: "update masterctrl set member_id = (?)",
                               arguments: [memid+1])
                } //try dbQueue.write
            
//            alertWithTitle(title: "บันทึกข้อมูลการลงทะเบียนเรียบร้อย", message: "สำเร็จ")
            
            let alert = UIAlertController(title: "สำเร็จ", message: "คุณได้สมัครสมาชิกเรียบร้อย กดตกลง เพื่อเข้าสู่หน้า Login", preferredStyle: .alert)
            let action = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.cancel,handler: {_ in
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mvc = storyboard.instantiateViewController(identifier: "login") as! loginMenu
                self.view.window?.rootViewController = mvc
            });
            alert.addAction(action)
            self.present(alert, animated: true, completion:nil)
            
                   
            } catch {
                    print(error.localizedDescription)
                   }
    }
    
    
    func alertWithTitle(title: String!, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel,handler: {_ in
            if title=="EMAIL ERROR!"{
                self.txtEmail.becomeFirstResponder()
            }
            else if title=="MEMID ERROR!"{
                    self.txtMemid.becomeFirstResponder()
            }
            else if title=="MEMNAME ERROR!"{
                    self.txtMemname.becomeFirstResponder()
            }
            else if title=="PASSWORD ERROR!"{
                    self.txtPass.becomeFirstResponder()
            }
            else if title=="REPASSWORD ERROR!"{
                    self.txtPass.becomeFirstResponder()
            }
            else{
//                self.txtRepass.becomeFirstResponder()
            }
        });
        alert.addAction(action)
        self.present(alert, animated: true, completion:nil)
    }
    

    func checkTextfieldisEmpty(){
        if txtMemid.text!.isEmpty {
            alertWithTitle(title: "MEMID ERROR!", message: "ไม่ใส่รหัสสมาชิก")
        }
        else if txtMemname.text!.isEmpty {
            alertWithTitle(title: "MEMNAME ERROR!", message: "ไม่ใส่ชื่อสมาชิก")
        }
        else if txtPass.text!.isEmpty {
            alertWithTitle(title: "PASSWORD ERROR!", message: "ไม่ใส่รหัสผ่าน")
        }
        if txtRepass.text!.isEmpty {
            alertWithTitle(title: "REPASSWORD ERROR!", message: "รหัสผ่านไม่ตรง")
        }
        else if txtEmail.text!.isEmpty {
            alertWithTitle(title: "EMAIL ERROR!", message: "ไม่ใส่อีเมล")
        }
    }
    
    
    
    func readDB4memberID(){
        do {
        let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
            try dbQueue.inDatabase { db in
                let rows = try Int.fetchOne(db, sql:
                "SELECT member_id FROM masterctrl")
                txtMemid.text=rows?.description
            }
        } catch {
        
            print(error.localizedDescription)
           }
    }
    
    func connect2DB(){
      config.readonly = true

      do{
       dbPath = try fileManager
          .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
          .appendingPathComponent("account_GRDB.sqlite")
          .path
          if !fileManager.fileExists(atPath: dbPath) {
              dbResourcePath = Bundle.main.path(forResource: "account_GRDB", ofType: "sqlite")!
              try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
          }
      }catch{
          print("An error has occured")
      }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //ตรวจสอบการ Touch นอก textfield
        //เพื่อเช็ค password หรือ email
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        connect2DB()
        readDB4memberID()
    }

}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    

}// end
