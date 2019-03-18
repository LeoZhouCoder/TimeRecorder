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
        return getAllIcons()[0]
    }
    
    static func getAllIcons() -> Results<Icon> {
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
    
    static func getAllActivityCategory() -> Results<ActivityCategory> {
        // statusItems = realm.objects(Status).filter("StatusID  > 111 ")
        // statusItems = self.realm.objects(Status).filter("StatusID > 111 ").filter("text = '这是第二条test'")
        // statusItems = self.realm.objects(Status).filter("StatusID > 111").sorted("StatusID")
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
    
    
    
    static func addActivity(_ name:String, _ icon: Icon, _ category: ActivityCategory) -> Bool {
        let item = Activity();
        item.name = name
        item.icon = icon
        try! realm.write {
            category.activities.append(item)
        }
        return true
    }
    
    static func updateActivity(_ item:Activity, _ name:String, _ icon: Icon, _ category:ActivityCategory) ->Bool {
        try! realm.write {
            item.name = name
            item.icon = icon
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
    
    
    static func addActivityRecord(_ name:String, _ icon: Icon) -> Bool {
        
        return true
    }
    
    static func updateActivityRecord(_ id:String, _ name:String, _ icon: Icon) ->Bool {
        
        return true
    }
    
    static func deleteActivityRecord(_ id:String) -> Bool {
        
        return true
    }
}
