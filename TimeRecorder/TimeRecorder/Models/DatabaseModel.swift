//
//  SettingModel.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

enum IconType: Int {
    case system, coutomize, deleted
}

class Icon: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var type: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: Data = Data()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityCategory: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var icon: Icon?
    
    let activities = List<Activity>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Activity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var icon: Icon?
    @objc dynamic var category: ActivityCategory?
    
    let linkToCategory = LinkingObjects(fromType: ActivityCategory.self, property: "activities")
    
    let records = List<ActivityRecord>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityRecord: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var startTime: Date = Date()
    @objc dynamic var endTime: Date?
    @objc dynamic var node: String?
    @objc dynamic var activity:Activity?
    
    let linkToActivity = LinkingObjects(fromType: Activity.self, property: "records")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


class DatabaseModel: NSObject {
    
    static let iconImages = ["IconWork", "IconHome", "IconFun"]
    
    // how to use realm safely
    static var realm: Realm {
        return try! Realm()
    }
    
    static func initDatabase() {
        // completely delete the Realm file
        //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        
        // completely empty the database
        /*try! realm.write {
            realm.deleteAll()
        }*/
        
        updateSystemIcons()
        print(realm.configuration.fileURL ?? "")
    }
    
    static func updateSystemIcons() {
        let icons = realm.objects(Icon.self)
        var savedSystemIcons: [String] = []
        for icon in icons {
            if icon.type != IconType.system.rawValue {
                continue
            }
            if iconImages.contains(icon.name) {
                savedSystemIcons.append(icon.name)
                continue
            }
            try! realm.write {
                icon.name = iconImages[0]
                icon.type = IconType.deleted.rawValue
            }
        }
        var newSystemIcons: [Icon] = []
        var iconObject: Icon
        for iconImage in iconImages {
            if savedSystemIcons.contains(iconImage) {
                continue
            }
            iconObject = Icon()
            iconObject.type = IconType.system.rawValue
            iconObject.name = iconImage
            newSystemIcons.append(iconObject)
        }
        try! realm.write {
            for icon in newSystemIcons {
                realm.add(icon)
            }
        }
    }
    
    static func getDefaultIcon() -> Icon {
        return getIcons()[0]
    }
    
    static func getIcons() -> Results<Icon> {
        return realm.objects(Icon.self).filter("type != \(IconType.deleted.rawValue) ").sorted(byKeyPath: "type")
    }
    
    static func addIcon(imageData: Data) -> Bool {
        let icon = Icon()
        icon.type = IconType.coutomize.rawValue
        icon.image = imageData
        try! realm.write {
             realm.add(icon)
        }
        return true
    }
    
    static func deleteIcon(icon: Icon) -> Bool {
        try! realm.write {
            realm.delete(icon)
        }
        return false
    }
    
    
    
    static func addActivityCategory(_ name:String, _ icon: Icon) -> Bool {
        let category = ActivityCategory()
        category.name = name
        category.icon = icon
        try! realm.write {
            realm.add(category)
        }
        return true
    }
    
    static func getActivityCategories() -> Results<ActivityCategory> {
        return realm.objects(ActivityCategory.self)
    }
    
    static func updateActivityCategory(_ category:ActivityCategory, _ name:String, _ icon: Icon) ->Bool {
        try! realm.write {
            category.name = name
            category.icon = icon
            realm.add(category, update: true)
        }
        return true
    }
    
    static func deleteActivityCategory(_ category:ActivityCategory) -> Bool {
        try! realm.write {
            realm.delete(category)
        }
        return true
    }
    
    static func getAllActivities() -> Results<Activity> {
        return realm.objects(Activity.self)
    }
    
    static func addActivity(_ name:String, _ icon: Icon, _ category: ActivityCategory) -> Bool {
        let item = Activity();
        item.name = name
        item.icon = icon
        item.category = category
        try! realm.write {
            category.activities.append(item)
        }
        return true
    }
    
    static func updateActivity(_ item:Activity,
                               _ name:String,
                               _ icon: Icon,
                               _ category:ActivityCategory) ->Bool {
        try! realm.write {
            item.name = name
            item.icon = icon
            item.category = category
            realm.add(item, update: true)
        }
        return true
    }
    
    static func deleteActivity(_ activity:Activity) -> Bool {
        try! realm.write {
            realm.delete(activity)
        }
        return true
    }
    
    
    static func addActivityRecord(activity: Activity,
                                  startTime: Date,
                                  endTime: Date,
                                  node: String) -> Bool {
        let record = ActivityRecord();
        record.activity = activity
        record.startTime = startTime
        record.endTime = endTime
        record.node = node
        try! realm.write {
            activity.records.append(record)
        }
        return true
    }
    
    static func updateActivityRecord(record: ActivityRecord,
                                     activity: Activity,
                                     startTime: Date,
                                     endTime: Date,
                                     node: String) ->Bool {
        try! realm.write {
            record.activity = activity
            record.startTime = startTime
            record.endTime = endTime
            record.node = node
            realm.add(record, update: true)
        }
        return true
    }
    
    static func deleteActivityRecord(record:ActivityRecord) -> Bool {
        try! realm.write {
            realm.delete(record)
        }
        return true
    }
    
    static func getActivityRecords(from startDate: Date?,
                                   to endDate: Date?,
                                   _ ascending:Bool = true) -> Results<ActivityRecord> {
        var records = realm.objects(ActivityRecord.self).sorted(byKeyPath: "startTime",ascending: ascending)
        if let startDate = startDate {
            records = records.filter("startTime >= %@ OR endTime > %@", startDate, startDate)
        }
        if let endDate = endDate {
            records = records.filter("endTime <= %@ OR startTime < %@", endDate, endDate)
        }
        return records
    }
    
    static func getActivityRecordsFillEmptyTime(from startDate: Date?,
                                                to endDate: Date?) -> [ActivityRecord] {
        /*var records = getActivityRecords(from: startDate, to: endDate, true)
        
        var date = startDate
        var record: ActivityRecord*/
        let recordArr = [ActivityRecord]()
        /*
         var date = startDate
         
         while records.count > 0 {
         
         var record  =  records.pop first one
         if record.startTime != date {
            new record startTime = date endTime = record.startTime
            push to arr
         }
         if record.endTime == nil {
            record.endTime = endDate
         }
         push record to arr
         date = record.endTime
         
         }
         
         
         
         */
        
    
        
        /*while records.count > 0 {
            //record = records.
        }
        for record in records {
            
        }*/
        return recordArr
    }
    
}
