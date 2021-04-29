//
//  ByTimeVC.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import UIKit
import Alamofire

class ByTimeVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var dataArray:[Datum]?
    
    @IBOutlet weak var tableview1: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataArray!.count
       
        return dataArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data",for:indexPath) as! ByTimeCell
        cell.txt_date.text = "วันที่ "+String(self.dataArray?[indexPath.row].date ?? "ERROR")
        cell.txt_confirm.text = "จำนวนผู้ติดเชื้อ "+String(self.dataArray?[indexPath.row].confirmed ?? 0)
        cell.txt_recoverd.text = "ผู้ที่รักษาหายแล้ว "+String(self.dataArray?[indexPath.row].recovered ?? 0)
        cell.txt_treating.text = "กำลังรักษา "+String(self.dataArray?[indexPath.row].hospitalized ?? 0)
        cell.txt_deaths.text = "เสียชีวิต "+String(self.dataArray?[indexPath.row].deaths ?? 0)
//        print(indexPath.row,"id pat")
//        cell.txt_deaths.text = String(indexPath.row)
        
        return cell
    }
    
    @IBAction func Btn_back(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyboard.instantiateViewController(identifier: "Menu") as! MenuVC
        self.view.window?.rootViewController = mvc
    }
    
    override func viewDidLoad() {
        loadData()
        tableview1.rowHeight=200
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func loadData()  {
        AF.request("https://covid19.th-stat.com/api/open/timeline", method: .get).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        let bysTime =  try decoder.decode(Bytime.self, from: data)
                        let _result = bysTime.data
                            self.dataArray = _result
                        print(self.dataArray![0])
                        self.tableview1.reloadData()
                            
                        
                        
//                        print(ArrayDat,type(of: ArrayDat))
                       
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
