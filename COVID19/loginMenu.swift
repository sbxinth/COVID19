//
//  ViewController.swift
//  final-project
//
//  Created by Anwa on 20/4/2564 BE.
//

import UIKit
import GRDB

class loginMenu: UIViewController {
    var dbPath : String = ""
    var dbResourcePath : String = ""
    var config = Configuration()
    let fileManager = FileManager.default
    //ใช้เก็บค่า Session พิเศษ รับค่าเป็น Array user
    var defaults = UserDefaults.standard
    var user:[String]=[]
    
    @IBOutlet weak var txtMemid: UITextField!
    @IBOutlet weak var txtPassw: UITextField!
    @IBAction func Btn_regist(_ sender: Any) {
    }
    func cusalert(Gmessage:String,Title:String,AlertOption:String){
        let alert = UIAlertController(title: Title, message: Gmessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertOption, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btnSignin(_ sender: Any) {
        if txtMemid.text != "" && txtPassw.text != "" {
            readDB4memberID(memid: txtMemid.text!, mempass: txtPassw.text!)
        }else{
            cusalert(Gmessage: "กรุณากรอกUsername/Password ให้ครบถ้วน", Title: "ไม่สามารถเข้าสู่ระบบ", AlertOption: "ตกลง")
        }
        
        print("btn down")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
           return true
        } else {
           return false
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
                 dbResourcePath = Bundle.main.path(forResource: "register_db", ofType: "sqlite")!
                 try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
             }
         }catch{
             print("An error has occured")
         }
       }
    
    func alertWithTitle(title: String!, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel,handler: {_ in
                if title=="ERROR"{
                    self.txtPassw.becomeFirstResponder()
                }
                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mvc = storyboard.instantiateViewController(identifier: "nav2") as! nav2ViewController
                self.view.window?.rootViewController = mvc
            });
            alert.addAction(action)
            self.present(alert, animated: true, completion:nil)
        }
    @objc func tap(sender: UITapGestureRecognizer){
            print("tapped")
            view.endEditing(true)
    }
    func readDB4memberID(memid:String,mempass:String){
        print("in read db")
        do {

        let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)

            try dbQueue.inDatabase { db in
                print("in qeuery")
                //Select all data from the table named tablename residing in SQLite

               let rows = try Row.fetchCursor(db, sql: "SELECT member_id,member_name,mem_passw FROM register where member_name = (?) and mem_passw = (?)",
               arguments: [memid,mempass])
//                print(xxx!["member_name"]!)
                print("pass fetch")
                
                if let row = try rows.next() {
                    print("pass")
                    

                     if memid == row["member_name"] &&  mempass == row["mem_passw"] {
                        //Goto NC1
                        let alert = UIAlertController(title: "สำเร็จ", message: "คุณได้ลงชื่อเข้าใช้เรียบร้อย", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.cancel,handler:nil);
                        alert.addAction(action)
                        self.present(alert, animated: true, completion:nil)
                        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let mvc = storyBoard.instantiateViewController(identifier: "nav2") as! nav2ViewController
                        user.append(row["member_id"])
                        user.append(row["member_name"])
                        user.append(row["mem_passw"])
                        defaults.set(user, forKey: "savedUser")
                        self.view.window?.rootViewController = mvc
                        
                     }
                }else{
                    cusalert(Gmessage: "ไม่สำเร็จ", Title: "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง", AlertOption: "ลองใหม่")
                }
            }
        } catch {
            print(error.localizedDescription)
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        connect2DB()
        if defaults.object(forKey: "savedUser") != nil {
            let notEmt=defaults.object(forKey: "savedUser") as! [String]
            print(notEmt)
            if notEmt.isEmpty == false{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "เนื่องจากคุณยังไม่ได้ออกจากระบบ ระบบจะพาไปสู่เมนูหลัก", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: {_ in
                    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mvc = storyboard.instantiateViewController(identifier: "Menu") as! MenuVC
                    self.view.window?.rootViewController = mvc
                });
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(action)
                self.present(alert, animated: true, completion:nil)
            }
        }
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}// end

