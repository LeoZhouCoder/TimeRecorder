//
//  Records.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/24.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

struct FilterModel {
    var startDate: Date?
    var endDate: Date?
    var activities: [Activity]?
    var note: String?
}

class Records: NSObject {
    static var realm: Realm {
        return try! Realm()
    }
    
    static var records: Results<ActivityRecord>?
    static func getRecords(filterModel: FilterModel) -> Results<ActivityRecord> {
        
        var records = realm.objects(ActivityRecord.self).sorted(byKeyPath: "startTime",ascending: false)
        
        if let startDate = filterModel.startDate {
            records = records.filter("startTime >= %@ OR endTime > %@", startDate, startDate)
        }
        
        if let endDate = filterModel.endDate {
            records = records.filter("endTime <= %@ OR startTime < %@", endDate, endDate)
        }
        
        if let note = filterModel.note {
            records = records.filter("tag CONTAINS %@", note)
        }
        
        /*if let activities = filterModel.activities {
            var activityNames: [String] = []
            for activity in activities {
                activityNames.append(activity.name)
            }
            records = records.filter("%@ CONTAINS activity.name", activityNames)
        }*/
        return records
    }
}
