//
//  ItemIcon.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//Copyright © 2019 LeoZhou. All rights reserved.
//

import Foundation
import RealmSwift

class Icon: Object {
    @objc dynamic var type = 0
    @objc dynamic var name = ""
    @objc dynamic var image = Data()
}

class ActivityCategory: Object {
    @objc dynamic var name = ""
    @objc dynamic var icon: Icon?
    
    let activities = List<Activity>()
}

class Activity: Object {
    @objc dynamic var name = ""
    @objc dynamic var icon: Icon?
    @objc dynamic var category: ActivityCategory?
    
    let records = List<ActivityRecord>()
}

class ActivityRecord: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var startTime = Date()
    @objc dynamic var endTime = Date()
    @objc dynamic var tag = ""
    @objc dynamic var activity: Activity?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
