//
//  ChatsViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import Charts

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chats"
        
        // Test Chats
        let chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 300)
        self.view.addSubview(chartView)
        
        var dataEntries = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "LineChat")
        let chartData = LineChartData(dataSets: [chartDataSet])
        chartView.data = chartData
    }
}
