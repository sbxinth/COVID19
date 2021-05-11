//
//  DailyStatVC.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import UIKit
import Alamofire

class DailyStatVC: UIViewController {

    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var txt_confirmed: UILabel!
    @IBOutlet weak var txt_recovered: UILabel!
    @IBOutlet weak var txt_treating: UILabel!
    @IBOutlet weak var txt_deadth: UILabel!
    //
    @IBOutlet weak var txt_newConfirm: UILabel!
    @IBOutlet weak var txt_NewRecoverd: UILabel!
    @IBOutlet weak var txt_NewTreating: UILabel!
    @IBOutlet weak var txt_NewDeath: UILabel!
    //
    @IBOutlet weak var txt_lastUpdate: UILabel!
    @IBOutlet weak var txt_credit: UILabel!
    

    
    func loadData()  {
        AF.request("https://covid19.th-stat.com/api/open/today", method: .get).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        let covidDailyModel =  try decoder.decode(CovidDailyModel.self, from: data)
                        self.txt_recovered.text = String(covidDailyModel.recovered)
                        self.txt_confirmed.text = String(covidDailyModel.confirmed)
                        self.txt_deadth.text = String(covidDailyModel.deaths)
                        self.txt_treating.text = String(covidDailyModel.hospitalized)
                        //
                        self.txt_newConfirm.text = String(covidDailyModel.newConfirmed)
                        self.txt_NewRecoverd.text = String(covidDailyModel.newRecovered)
                        self.txt_NewDeath.text = String(covidDailyModel.newDeaths)
                        self.txt_NewTreating.text = String(covidDailyModel.newDeaths)
                        self.txt_lastUpdate.text = "อัพเดทล่าสุดเมื่อ "+covidDailyModel.updateDate!
                        self.txt_credit.text = covidDailyModel.devBy
                     }catch let error {
                        print(error)
                     }
                     break
                    
                case .failure(let error):
                    print(error)
                    break
                }
        }
        
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
