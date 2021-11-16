//
//  LogViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 19/03/21.
//

import UIKit
import Charts

class LogViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var suffLabel: UILabel!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var topView: UIView!
    
    let points = ["1s","2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "10s", "11s"]
    let value = [1,1,2,4,4,4,4,3,3,4,4]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizePieChart(dataPoints: points, values: value.map{ Double($0) })
        customizeBarChart(dataPoints: points, values: value.map{ Double($0) })
        suffLabel.isHidden = true
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                topView.isHidden = false
                botView.isHidden = false
                suffLabel.isHidden = true
                customizePieChart(dataPoints: points, values: value.map{ Double($0) })
                customizeBarChart(dataPoints: points, values: value.map{ Double($0) })
            case 1:
                //customizePieChart(dataPoints: players, values: tomgoals.map{ Double($0) })
                //customizeBarChart(dataPoints: players, values: tomgoals.map{ Double($0) })
                topView.isHidden = true
                botView.isHidden = true
                suffLabel.isHidden = false
            default:
                break
            }
    }
    func customizePieChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = ChartColorTemplates.material()
          
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          
          pieChartView.data = pieChartData
    }
    
    func customizeBarChart(dataPoints: [String], values: [Double]) {
          // TO-DO: customize the chart here
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Count")
        chartDataSet.colors = ChartColorTemplates.material()
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
