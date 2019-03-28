//
//  GroupEditViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: BasicItemsTableViewController, EditActivityViewProtocol {
    
    var categories: Results<ActivityCategory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.register(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityCell")
        
        categories = DatabaseModel.getActivityCategories()
    }
    
    override func tappedAddButton() {
        let vc = EditActivityViewController(with: EditActivityModel.getNewActivityModel(), delegate: self)
        vc.title = "New Category"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func longPressRow(at indexPath: IndexPath) {
        let category = categories![indexPath.row]
        let vc = EditActivityViewController(
            with: EditActivityModel.getEditActivityModel(from: category as Object, name: category.name, icon: category.icon!),
            delegate: self)
        vc.title = "Edit Category"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        cell.accessoryType = .disclosureIndicator
        let category = categories![indexPath.row]
        cell.icon = category.icon
        cell.name = category.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = categories![indexPath.row]
            print("delete \(category.name)")
            if category.activities.count != 0 {
                let alertController = UIAlertController(
                    title: "提示",
                    message: "该分类中还有其他项目，请先删除项目然后删除分类",
                    preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "确认", style: .default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true)
                
            }else{
                let result = DatabaseModel.deleteActivityCategory(category)
                if !result {
                    fatalError("delete ActivityCategory error")
                }
                self.tableView?.reloadData()
            }
        }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories![indexPath.row]
        let vc = ActivitiesViewController(with: category, title: "Activities", showTabBar: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didEditActivity(editActivityModel: EditActivityModel) {
        switch editActivityModel.type {
        case EditableActivityType.edit:
            let category = editActivityModel.object as! ActivityCategory
            let result = DatabaseModel.updateActivityCategory(category, editActivityModel.name, editActivityModel.icon)
            if !result {
                fatalError("updateActivityCategory error")
            }
        case EditableActivityType.new:
            let result = DatabaseModel.addActivityCategory(editActivityModel.name, editActivityModel.icon)
            if !result {
                fatalError("addActivityCategory error")
            }
        }
        self.tableView?.reloadData()
    }
}
