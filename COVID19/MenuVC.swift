//
//  MenuVC.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import UIKit

class MenuVC: UIViewController {
    var defaults = UserDefaults.standard
    @IBOutlet weak var txt_hiUser: UILabel!
    @IBAction func btn_logout(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vmc = storyBoard.instantiateViewController(identifier: "login") as! loginMenu
        self.view.window?.rootViewController = vmc
        defaults.removeObject(forKey: "savedUser")
        print("Logged out")
    }
    @IBAction func Btn_daily(_ sender: Any) {
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let mvc = storyboard.instantiateViewController(identifier: "Daily") as! DailyStatVC
//        self.view.window?.rootViewController = mvc
    }
    @IBAction func Btn_byTime(_ sender: Any) {
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let mvc = storyboard.instantiateViewController(identifier: "ByTime") as! ByTimeVC
//        self.view.window?.rootViewController = mvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.object(forKey: "savedUser") != nil{
            let sss = defaults.object(forKey: "savedUser") as! [String]
            txt_hiUser.text = "Hi, "+sss[1]
        }
        
        
//        print(sss[1])
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
