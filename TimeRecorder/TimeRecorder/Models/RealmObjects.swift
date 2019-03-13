//
//  ItemIcon.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//Copyright © 2019 LeoZhou. All rights reserved.
//

import Foundation
import RealmSwift

class ActivityIcon: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var image = Data()
    @objc dynamic var type = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityGroup: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var icon: ActivityIcon?
    
    let  items = List<ActivityItem>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityItem: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var icon: ActivityIcon?
    @objc dynamic var group: ActivityGroup?
    
    let records = List<ActivityRecord>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityRecord: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var startTime = Date()
    @objc dynamic var endTime = Date()
    @objc dynamic var tag = ""
    @objc dynamic var item: ActivityItem?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
