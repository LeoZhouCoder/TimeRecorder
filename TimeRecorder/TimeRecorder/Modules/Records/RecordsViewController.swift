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

class RecordsViewController: BasicItemsTableViewController, EditRecordViewProtocol {
    
    var records: Results<ActivityRecord>?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tappedAddButton() {
        let vc = EditRecordViewController(with: nil, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didEditRecord(editRecordModel:EditRecordModel) {
        switch editRecordModel.editType {
        case EditRecordType.modify:
            let result = DatabaseModel.updateActivityRecord(record: editRecordModel.record!,
                                               activity: editRecordModel.activity,
                                               startTime: editRecordModel.startDate,
                                               endTime: editRecordModel.endDate,
                                               node: editRecordModel.node!)
            if !result {
                fatalError("updateActivityCategory error")
            }
        case EditRecordType.new:
            let result = DatabaseModel.addActivityRecord(activity: editRecordModel.activity,
                                            startTime: editRecordModel.startDate,
                                            endTime: editRecordModel.endDate,
                                            node: editRecordModel.node!)
            if !result {
                fatalError("addActivityCategory error")
            }
        }
        self.tableView?.reloadData()
    }
}
