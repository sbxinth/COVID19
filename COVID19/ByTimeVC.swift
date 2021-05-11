//
//  ByTimeVC.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import UIKit
import Alamofire
import FirebaseDatabase

class ByTimeVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    private let database = Database.database(url: "https://covid-19-oak-default-rtdb.asia-southeast1.firebasedatabase.app/").reference()
    var dataArray:[Datum]?
    var temparray:Datum?
    var dataforBackup = [String:Any]()
    var picked=false
    var lastDate=String()
    var  datedes=Date()
    @IBOutlet weak var datePKol: UIDatePicker!
    @IBAction func datePK(_ sender: Any) {
        print("test")
        datePKol.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate = dateFormatter.string(from: datePKol.date)
        print(selectedDate)
        for i in 0..<dataArray!.count {
            if dataArray![i].date == selectedDate {
                print("found")
                temparray = dataArray![i]
//                dataArray = [temparray]
                
//                print(temparray,"temp")
                picked=true
                tableview1.reloadData()
//                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                    //        return self.dataArray!.count
//
//                            return 1
//                        }
//                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "data",for:indexPath) as! ByTimeCell
//                    cell.txt_date.text = "วันที่ "+String(self.temparray!.date )
//                    cell.txt_confirm.text = "จำนวนผู้ติดเชื้อ "+String(self.temparray!.confirmed )
//                    cell.txt_recoverd.text = "ผู้ที่รักษาหายแล้ว "+String(self.temparray!.recovered )
//                    cell.txt_treating.text = "กำลังรักษา "+String(self.temparray!.hospitalized )
//                    cell.txt_deaths.text = "เสียชีวิต "+String(self.temparray!.deaths )
//            //        print(indexPath.row,"id pat")
//            //        cell.txt_deaths.text = String(indexPath.row)
//
//                    return cell
//                }
//
//                break
            }else{
                print(dataArray![i].date," AND ",selectedDate)
                picked=true
                tableview1.reloadData()
                print("not found")
            }
        }
    }
    @IBOutlet weak var tableview1: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataArray!.count
        if picked==true{
            return 1
        }
        return dataArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data",for:indexPath) as! ByTimeCell
        cell.txt_date.text = "วันที่ "+String(self.dataArray?[indexPath.row].date ?? "ERROR")
        cell.txt_confirm.text = "จำนวนผู้ติดเชื้อ "+String(self.dataArray?[indexPath.row].confirmed ?? 0)
        cell.txt_recoverd.text = "ผู้ที่รักษาหายแล้ว "+String(self.dataArray?[indexPath.row].recovered ?? 0)
        cell.txt_treating.text = "กำลังรักษา "+String(self.dataArray?[indexPath.row].hospitalized ?? 0)
        cell.txt_deaths.text = "เสียชีวิต "+String(self.dataArray?[indexPath.row].deaths ?? 0)
        cell.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
//        print(indexPath.row,"id pat")255,250,205
//        cell.txt_deaths.text = String(indexPath.row)
        if picked==true{
            cell.txt_date.text = "วันที่ "+String(self.temparray!.date )
            cell.txt_confirm.text = "จำนวนผู้ติดเชื้อ "+String(self.temparray!.confirmed )
            cell.txt_recoverd.text = "ผู้ที่รักษาหายแล้ว "+String(self.temparray!.recovered )
            cell.txt_treating.text = "กำลังรักษา "+String(self.temparray!.hospitalized )
            cell.txt_deaths.text = "เสียชีวิต "+String(self.temparray!.deaths )
            cell.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
            return cell
        }
        return cell
    }
    func coppyDataToArray() -> (Date: Array<Any>, newConfirm: Array<Any>,newRecovered:Array<Any>,newHospitalized:Array<Any>,newDeaths:Array<Any>,confirmed:Array<Any>,recovered:Array<Any>,hospitalized:Array<Any>,deaths:Array<Any>){
        var AllDate=[String]()
        var AllnewConfirmed=[Int]()
        var AllnewRecovered=[Int]()
        var AllnewHospitalized=[Int]()
        var AllnewDeaths=[Int]()
        var Allconfirmed=[Int]()
        var Allrecovered=[Int]()
        var Allhospitalized=[Int]()
        var Alldeaths=[Int]()
        for i in 0..<dataArray!.count{
            AllDate.append(dataArray![i].date)
            AllnewConfirmed.append(dataArray![i].newConfirmed)
            AllnewRecovered.append(dataArray![i].newRecovered)
            AllnewHospitalized.append(dataArray![i].newHospitalized)
            AllnewDeaths.append(dataArray![i].newDeaths)
            Allconfirmed.append(dataArray![i].confirmed)
            Allrecovered.append(dataArray![i].recovered)
            Allhospitalized.append(dataArray![i].hospitalized)
            Alldeaths.append(dataArray![i].deaths)
        }
        return (AllDate,AllnewConfirmed,AllnewRecovered,AllnewHospitalized,AllnewDeaths,Allconfirmed,Allrecovered,Allhospitalized,Alldeaths)
        
    }
    func createDicArray(){
        dataforBackup=[
            "Date":coppyDataToArray().Date,
            "NewConfirm":coppyDataToArray().newConfirm,
            "newRecovered":coppyDataToArray().newRecovered,
            "newHospitalized":coppyDataToArray().newHospitalized,
            "newDeaths":coppyDataToArray().newDeaths,
            "confirmed":coppyDataToArray().confirmed,
            "recovered":coppyDataToArray().recovered,
            "hospitalized":coppyDataToArray().hospitalized,
            "deaths":coppyDataToArray().deaths]
        
    }

    
    override func viewDidLoad() {
        loadData()
        tableview1.rowHeight=200
        tableview1.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
        
     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        print("coppy data",self.coppyDataToArray().newConfirm)
        
     }
        
        datePKol.maximumDate=datedes
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
                        // upload to realtime data base here <<<- --
                        print(self.dataArray![0])
                        self.tableview1.reloadData()
                        
                        for i in 0..<self.dataArray!.count{
                            self.lastDate=self.dataArray![i].date
                            print(self.lastDate,type(of: self.lastDate))
                            
                        }
                        let dateFormatter = DateFormatter()
                //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        self.datedes = dateFormatter.date(from:self.lastDate)!
                        
//                        print(ArrayDat,type(of: ArrayDat))
                        self.addNewEntry()
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
    @objc private func addNewEntry() {
//        let object: [String: Any] = [
//            "All Data": dataArray!
//        ]
//        print(object)
        createDicArray()
        print(dataforBackup,"in add new Entry")
        database.child("DataBackup").setValue(dataforBackup)
        print(dataArray,"datARRR")
    }

}
