//
//  ActivitiesViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class ActivitiesViewController: BasicItemsTableViewController, EditActivityViewProtocol {

    var category: ActivityCategory
    var activities: List<Activity>?
    
    init(with category: ActivityCategory, title: String, showTabBar: Bool) {
        self.category = category
        super.init(title: title, showTabBar: showTabBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.register(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityCell")
        
        activities = category.activities
    }
    
    override func tappedAddButton() {
        let vc = EditActivityViewController(with: EditActivityModel.getNewActivityModel(), delegate: self)
        vc.title = "New Activity"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        let activity = activities![indexPath.row]
        cell.icon = activity.icon
        cell.name = activity.name
        return cell
    }
    
    override func longPressRow(at indexPath: IndexPath) {
        let activity = activities![indexPath.row]
        let vc = EditActivityViewController(
            with: EditActivityModel.getEditActivityModel(from: activity as Object, name: activity.name, icon: activity.icon!),
            delegate: self)
        vc.title = "Edit Activity"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let activity = activities![indexPath.row]
            DataManager.shareManager.deleteActivity(activity: activity)
            self.tableView?.reloadData()
        }
    }
    
    func didEditActivity(editActivityModel: EditActivityModel) {
        switch editActivityModel.type {
        case EditableActivityType.edit:
            let activity = editActivityModel.object as! Activity
            DataManager.shareManager.updateActivity(activity: activity, name: editActivityModel.name, icon: editActivityModel.icon, category: category)
        case EditableActivityType.new:
            DataManager.shareManager.addActivity(name: editActivityModel.name, icon: editActivityModel.icon, category: category)
        }
        activities = category.activities
        self.tableView?.reloadData()
    }
}
