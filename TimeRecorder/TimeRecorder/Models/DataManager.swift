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
    case system, coutomize
}

class Icon: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var type = 0
    @objc dynamic var name = ""
    @objc dynamic var image = Data()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ActivityCategory: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var icon: Icon?
    
    let activities = List<Activity>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Activity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
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
    @objc dynamic var startTime = Date()
    @objc dynamic var endTime: Date?
    @objc dynamic var node: String?
    @objc dynamic var activity:Activity?
    
    let linkToActivity = LinkingObjects(fromType: Activity.self, property: "records")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class DataManager: NSObject {
    
    static let shareManager = DataManager(reset: false)
    
    private let systemIconImages = ["IconWork", "IconHome", "IconFun"]
    
    private var realm: Realm {
        do {
            return try Realm()
        }catch {
            fatalError("Can't get Realm. Error: \(error)")
        }
    }
    
    var defaultIcon: Icon?
    var defaultActivity: Activity?
    
    init(reset: Bool = false) {
        super.init()
        if reset {
            deleteRealm()
        }
        updateSystemIcons()
        print(realm.configuration.fileURL ?? "")
    }
    
    private func realmAdd(object: RealmSwift.Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        }catch {
            fatalError("Realm add object: \(object) error: \(error)")
        }
    }
    
    private func realmDelete(object: RealmSwift.Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        }catch {
            fatalError("Realm delete object: \(object) error: \(error)")
        }
    }
    
    private func deleteRealm() {
        let realmFileURL = Realm.Configuration.defaultConfiguration.fileURL
        guard realmFileURL != nil else { return }
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: realmFileURL!.absoluteString) else { return }
        do {
            try fileManager.removeItem(at: realmFileURL!)
        }catch{
            fatalError("Delete Realm file failed. Error: \(error)")
        }
    }
    
    private func updateSystemIcons() {
        guard !systemIconImages.isEmpty else {
            fatalError("No system icon image!")
        }
        // set default icon
        let result = realm.objects(Icon.self).filter("name == %@", systemIconImages[0])
        if result.count == 0 {
            defaultIcon = addIcon(name: systemIconImages[0], image: nil)
        }else{
            defaultIcon = result[0]
        }
        
        // update icons
        let icons = realm.objects(Icon.self)
        var currentSystemIcons: [String] = []
        for icon in icons {
            // coutomize icons
            if icon.type != IconType.system.rawValue {
                continue
            }
            // current system icons
            if systemIconImages.contains(icon.name) {
                currentSystemIcons.append(icon.name)
                continue
            }
            // deleted system icons
            // replace to defaultIcon
            replaceCategoryIcon(original: icon, new: defaultIcon!)
            replaceActivityIcon(original: icon, new: defaultIcon!)
            // delete icon
            realmDelete(object: icon)
        }
        for iconImage in systemIconImages {
            if currentSystemIcons.contains(iconImage) {
                continue
            }
            addIcon(name: iconImage, image: nil)
        }
    }
    
    private func replaceCategoryIcon(original: Icon, new: Icon) {
        let categories = realm.objects(ActivityCategory.self).filter("icon.id == %@", original.id)
        for category in categories {
            updateActivityCategory(category: category, name: nil, icon: new)
        }
    }
    
    private func replaceActivityIcon(original: Icon, new: Icon) {
        let activities = realm.objects(Activity.self).filter("icon.id == %@", original.id)
        for activity in activities {
            updateActivity(activity: activity, name: nil, icon: new, category: nil)
        }
    }
    
    func getIcons() -> Results<Icon> {
        return realm.objects(Icon.self).sorted(byKeyPath: "type")
    }
    
    private func addIcon(name: String?, image: Data?) -> Icon? {
        guard name != nil || image != nil else {
            return nil
        }
        let icon = Icon()
        if let name = name {
            icon.name = name
            icon.type = IconType.system.rawValue
        }
        if let image = image {
            icon.image = image
            icon.type = IconType.coutomize.rawValue
        }
        realmAdd(object: icon)
        return icon
    }
    
    func addActivityCategory(name:String, icon: Icon) {
        let category = ActivityCategory()
        category.name = name
        category.icon = icon
        realmAdd(object: category)
    }
    
    func getActivityCategories() -> Results<ActivityCategory> {
        return realm.objects(ActivityCategory.self)
    }
    
    func updateActivityCategory(category: ActivityCategory, name: String?, icon: Icon?) {
        guard name != nil || icon != nil else { return }
        do {
            try realm.write {
                if let name = name {
                     category.name = name
                }
                if let icon = icon {
                    category.icon = icon
                }
                realm.add(category, update: true)
            }
        }catch {
            fatalError("Realm update ActivityCategory: \(category) error: \(error)")
        }
    }
    
    func deleteActivityCategory(category: ActivityCategory) {
        realmDelete(object: category)
    }
    
    func getAllActivities() -> Results<Activity> {
        return realm.objects(Activity.self)
    }
    
    func addActivity(name: String, icon: Icon, category: ActivityCategory) {
        let activity = Activity();
        activity.name = name
        activity.icon = icon
        activity.category = category
        realmAdd(object: activity)
    }
    
    func updateActivity(activity: Activity,
                        name: String?,
                        icon: Icon?,
                        category: ActivityCategory?) {
        guard name != nil || icon != nil || category != nil else { return }
        do {
            try realm.write {
                if let name = name {
                    activity.name = name
                }
                if let icon = icon {
                    activity.icon = icon
                }
                if let category = category {
                    activity.category = category
                }
                realm.add(activity, update: true)
            }
        }catch {
            fatalError("Realm update Activity: \(activity) error: \(error)")
        }
    }
    
    func deleteActivity(activity: Activity) {
        realmDelete(object: activity)
    }
    
    
    func addActivityRecord(activity: Activity,
                           startTime: Date,
                           endTime: Date?,
                           node: String?) {
        let record = ActivityRecord();
        record.activity = activity
        record.startTime = startTime
        record.endTime = endTime
        record.node = node
        realmAdd(object: record)
    }
    
    func updateActivityRecord(record: ActivityRecord,
                              activity: Activity?,
                              startTime: Date?,
                              endTime: Date?,
                              node: String?) {
        guard activity != nil || startTime != nil || endTime != nil || node != nil else {
            return
        }
        do {
            try realm.write {
                if let activity = activity {
                    record.activity = activity
                }
                if let startTime = startTime {
                    record.startTime = startTime
                }
                record.endTime = endTime
                record.node = node
                realm.add(record, update: true)
            }
        }catch {
            fatalError("Realm update ActivityRecord: \(record) error: \(error)")
        }
    }
    
    func deleteActivityRecord(record: ActivityRecord) {
        realmDelete(object: record)
    }
    
    func getActivityRecords(from startDate: Date?,
                            to endDate: Date?,
                            _ ascending: Bool = true) -> Results<ActivityRecord> {
        var records = realm.objects(ActivityRecord.self).sorted(byKeyPath: "startTime",ascending: ascending)
        if let startDate = startDate {
            records = records.filter("startTime >= %@ OR endTime > %@", startDate, startDate)
        }
        if let endDate = endDate {
            records = records.filter("endTime <= %@ OR startTime < %@", endDate, endDate)
        }
        return records
    }
}
