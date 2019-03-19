//
//  RecordsViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

enum PeriodType {
    case all,day,week,month,quarter,year,custom
}

struct PeriodData {
    var startDate: Date?
    var endDate: Date?
    /*static func getPeriodDataByPeriodType(type:PeriodType) -> PeriodData
    {
        var periodData:PeriodData
        switch type {
        case .all:
            periodData = PeriodData(nil, nil)
        case .day:
            Date(
        default:
            <#code#>
        }
        return periodData
    }*/
}

struct FilterModel {
    var period: PeriodData
    var activities: List<Activity>
    var tag:String
}

class RecordsViewController: UIViewController {
    
    var records: Results<ActivityRecord>?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Records"
    }
    
}
