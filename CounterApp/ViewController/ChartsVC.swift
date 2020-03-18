//
//  ChartsVC.swift
//  CounterApp
//
//  Created by Chanh Dat Ng on 10/18/19.
//  Copyright © 2019 Chanh Dat Ng. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase
import FirebaseFirestore

class ChartsVC: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: BarChartView!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    var listWeek = [Customers]()
    var months : [String]!
    
    
    var PieEntries = [PieChartDataEntry]()
    var day1 = PieChartDataEntry(value:0)
    var day2 = PieChartDataEntry(value:0)
    var day3 = PieChartDataEntry(value:0)
    var day4 = PieChartDataEntry(value:0)
    var day5 = PieChartDataEntry(value:0)
    var day6 = PieChartDataEntry(value:0)
    var day7 = PieChartDataEntry(value:0)
    
    var BarEntries = [BarChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pieChart.chartDescription?.text = "Weekly Statistic"
//        self.barChart.chartDescription?.text = "Monthly Statistic"
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        
        for i in (0...self.delegate.listCustomers.count-1).reversed(){
            if (self.delegate.listCustomers[i].day == "Sunday"){
                self.listWeek.append(self.delegate.listCustomers[i])
                self.listWeek.append(self.delegate.listCustomers[i-1])
                self.listWeek.append(self.delegate.listCustomers[i-2])
                self.listWeek.append(self.delegate.listCustomers[i-3])
                self.listWeek.append(self.delegate.listCustomers[i-4])
                self.listWeek.append(self.delegate.listCustomers[i-5])
                self.listWeek.append(self.delegate.listCustomers[i-6])
                break
            }
        }
        
        day1.value = Double(self.listWeek[6].count)
        day1.label = "Mon"
        day2.value = Double(self.listWeek[5].count)
        day2.label = "Tue"
        day3.value = Double(self.listWeek[4].count)
        day3.label = "Wed"
        day4.value = Double(self.listWeek[3].count)
        day4.label = "Thu"
        day5.value = Double(self.listWeek[2].count)
        day5.label = "Fri"
        day6.value = Double(self.listWeek[1].count)
        day6.label = "Sat"
        day7.value = Double(self.listWeek[0].count)
        day7.label = "Sun"
        
        PieEntries = [day1,day2,day3,day4,day5,day6,day7]
        updatePieChartData()
        setChart()
    }
    
    func updatePieChartData(){
        let chartDataSet = PieChartDataSet(entries: PieEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        var colors = [UIColor]()
        for _ in 0..<PieEntries.count {
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
            }
        chartDataSet.colors = colors

        pieChart.data = chartData
        pieChart.animate(yAxisDuration: 1.25,
                         easingOption: .linear)
        pieChart.holeColor = UIColor.clear
        pieChart.holeRadiusPercent = 0.2
        pieChart.transparentCircleRadiusPercent = 0.3
    }
    
//    func setChartMonths(_ customers_year : [Int]) {
//
//        barChart.noDataText = "You need to provide data for the chart."
//         let test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
//
//         var dataEntries: [BarChartDataEntry] = []
//
//        for i in 0..<self.months.count
//        {
//            let dataEntry = BarChartDataEntry(x: Double(test[i]), y: Double(customers_year[i]), data: months as AnyObject?)
//            dataEntries.append(dataEntry)
//         }
//
//         let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Customers each month")
//         let chartData = BarChartData(dataSet: chartDataSet)
//         barChart.data = chartData
//        barChart.xAxis.labelPosition = .bottom
//        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//    }
    func setChart(){
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [1000.0,950.0, 900.0, 1600.0, 1200.0, 700.0, 1400.0, 1800.0, 2000.0, 1250.0, 1500.0, 1300.0]
        
        barChart.setBarChartData(xValues: months, yValues: unitsSold, label: "Monthly Customers")
        barChart.xAxis.labelPosition = .bottom
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
}

extension BarChartView {

    private class BarChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setBarChartData(xValues: [String], yValues: [Double], label: String) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
    }
}
