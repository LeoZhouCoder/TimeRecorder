//
//  SettingModel.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseModel: NSObject {
    
    let icons = ["IconWork", "IconHome", "IconFun"]
    let realm = try! Realm()
    
    func initDatabase() -> Bool {
        let items = realm.objects(ActivityIcon.self)
        if items.count > 0 {
            return true
        }
        self.addSystemIcoms()
        print(realm.configuration.fileURL ?? "")
        return true
    }
    
    func addSystemIcoms() {
        var icon:ActivityIcon
        var image: UIImage!
        var iconObjects: [ActivityIcon] = []
        for iconName in icons {
            icon = ActivityIcon()
            icon.type = 0
            image = UIImage(named :iconName)
            icon.image = image.pngData()!
            iconObjects.append(icon)
        }
        try! realm.write {
            for iconObject in iconObjects {
                realm.add(iconObject)
            }
        }
    }
    
    func addIcon(imageData: Data) -> Bool {
        let icon = ActivityIcon()
        icon.type = 1
        icon.image = imageData
        try! realm.write {
             realm.add(icon)
        }
        return true
    }
    
    func deleteIcon(icon: ActivityIcon) -> Bool {
        try! realm.write {
            realm.delete(icon)
        }
        return false
    }
    
    
    
    func addActivityGroup(_ name:String, _ icon: ActivityIcon) -> Bool {
        let group = ActivityGroup()
        group.name = name
        group.icon = icon
        try! realm.write {
            realm.add(group)
        }
        return true
    }
    
    public func getActivityGroup(from id : String) -> ActivityGroup? {
        
        // statusItems = realm.objects(Status).filter("StatusID  > 111 ")
        // statusItems = self.realm.objects(Status).filter("StatusID > 111 ").filter("text = '这是第二条test'")
        // statusItems = self.realm.objects(Status).filter("StatusID > 111").sorted("StatusID")

        return realm.object(ofType: ActivityGroup.self, forPrimaryKey: id)
    }
    
    func updateActivityGroup(_ group:ActivityGroup, _ name:String, _ icon: ActivityIcon) ->Bool {
        group.name = name
        group.icon = icon
        
        try! realm.write {
            realm.add(group, update: true)
        }
        return true
    }
    
    func deleteActivityGroup(_ group:ActivityGroup) -> Bool {
        try! realm.write {
            realm.delete(group)
        }
        return true
    }
    
    
    
    func addActivityItem(_ name:String, _ icon: ActivityIcon, _ group: ActivityGroup) -> Bool {
        let item = ActivityItem();
        item.name = name
        item.icon = icon
        item.group = group
        try! realm.write {
            realm.add(item)
        }
        return true
    }
    
    func updateActivityItem(_ item:ActivityItem, _ name:String, _ icon: ActivityIcon, _ group:ActivityGroup) ->Bool {
        item.name = name
        item.icon = icon
        item.group = group
        try! realm.write {
            realm.add(item, update: true)
        }
        return true
    }
    
    func deleteActivityItem(_ item:ActivityItem) -> Bool {
        try! realm.write {
            realm.delete(item)
        }
        return true
    }
    
    
    
    func addActivityRecord(_ name:String, _ icon: ActivityIcon) -> Bool {
        
        return true
    }
    
    func updateActivityRecord(_ id:String, _ name:String, _ icon: ActivityIcon) ->Bool {
        
        return true
    }
    
    func deleteActivityRecord(_ id:String) -> Bool {
        
        return true
    }
}
