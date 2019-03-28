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

    var chatType:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Chats"
        //
        let fullScreenSize = UIScreen.main.bounds.size
        let segmentedControl = UISegmentedControl(
            items: [UIImage(named:"IconArrowBack")!,
                    Date().toString(format: "yyyy-MM-dd"),
                    UIImage(named:"IconArrowForward")!,
                    "PieChat",
                    "BarChat"])
        segmentedControl.setWidth(50, forSegmentAt: 0)
        segmentedControl.setWidth(50, forSegmentAt: 2)
        segmentedControl.setWidth(70, forSegmentAt: 3)
        segmentedControl.setWidth(70, forSegmentAt: 4)
        segmentedControl.layer.borderColor = UIColor.clear.cgColor
        chatType = 0
        segmentedControl.selectedSegmentIndex = chatType + 3
        
        segmentedControl.addTarget(
            self,
            action:
            #selector(ChatsViewController.onChange),
            for: .valueChanged)
        
        segmentedControl.frame.size = CGSize(width: fullScreenSize.width, height: 30)
        segmentedControl.center = CGPoint(x: fullScreenSize.width * 0.5, y: fullScreenSize.height * 0.25)
        self.view.addSubview(segmentedControl)
        
        // Test Chats
        let chartView = LineChartView()
         chartView.frame = CGRect(x: 20, y: 120, width: self.view.bounds.width - 40, height: 300)
         self.view.addSubview(chartView)
         
         var dataEntries = [ChartDataEntry]()
         for i in 0..<10 {
         let y = arc4random()%100
         let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
         dataEntries.append(entry)
         }
         let chartDataSet = LineChartDataSet(values: dataEntries, label: "LineChat")
         let chartData = LineChartData(dataSets: [chartDataSet])
         chartView.data = chartData
    }
    // 切換選項時執行動作的方法
    @objc func onChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Pre Date")
            sender.selectedSegmentIndex = chatType + 3
        case 1:
            print("Select Date")
            sender.selectedSegmentIndex = chatType + 3
        case 2:
            print("Next Date")
            sender
                .selectedSegmentIndex = chatType + 3
        case 3:
            chatType = 0
        case 4:
            chatType = 1
        default:
            print("Select Index: \(sender.selectedSegmentIndex)")
        }
        // 印出選到哪個選項 從 0 開始算起
        print(sender.selectedSegmentIndex)
        
        // 印出這個選項的文字
        // print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
    }
    
    func showPieChat() {
        
    }
}
