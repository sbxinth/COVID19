//
//  sampleChart.swift
//  final-project
//
//  Created by Anwa on 27/4/2564 BE.
//

import UIKit
import Charts
import Alamofire

class exampleChart: UIViewController{
    var dd = -1
    var dataArray:[Datum]?
    @IBOutlet weak var chtChart: LineChartView!
    
    var months = [String]()
    
       override func viewDidLoad() {
           super.viewDidLoad()
           self.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print(self.dataArray!.count ?? "error","xxx")
            for i in self.dataArray!.count-7..<self.dataArray!.count{
                self.months.append(String(self.dataArray![i].date))
            }
            self.updateGraph()
        }
           
       }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
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

       func updateGraph(){
        // set 1 //
           var lineChartEntry  = [ChartDataEntry]()
           var lineChartEntry2  = [ChartDataEntry]()
           var lineChartEntry3  = [ChartDataEntry]()
        for i in dataArray!.count-7..<dataArray!.count {
            
            dd+=1
            let value = ChartDataEntry(x: Double(dd), y: Double((dataArray![i].newConfirmed)))
               lineChartEntry.append(value)
            let value2 = ChartDataEntry(x: Double(dd), y: Double((dataArray![i].newRecovered)))
            lineChartEntry2.append(value2)
            let value3 = ChartDataEntry(x: Double(dd), y: Double((dataArray![i].newDeaths)))
            lineChartEntry3.append(value3)
            
           }

           let line1 = LineChartDataSet(entries: lineChartEntry, label: "ผู้ติดเชื้อรายใหม่")
           line1.colors = [NSUIColor.red]
        
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "รักษาหายแล้วล่าสุด")
        line2.colors = [NSUIColor.green]
        
        let line3 = LineChartDataSet(entries: lineChartEntry3, label: "จำนวนผู้เสียชีวิตล่าสุด")
        line3.colors = [NSUIColor.black]

           let data = LineChartData()
        data.addDataSet(line1)
        data.addDataSet(line2)
        data.addDataSet(line3)
        // end//
        
           
        chtChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        chtChart.xAxis.granularity = 1
        chtChart.xAxis.labelPosition = .top
           
        chtChart.data = data
        chtChart.chartDescription?.text = "กราฟแสดงสถิติ 7 วันที่ผ่านมา "
       }
}// end
