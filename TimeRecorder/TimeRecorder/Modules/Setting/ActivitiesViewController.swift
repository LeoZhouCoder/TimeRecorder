//
//  ActivitiesViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditActivityViewProtocol, UIGestureRecognizerDelegate {

    var category: ActivityCategory
    var activities: List<Activity>?
    var tableView: UITableView?
    
    init(with category: ActivityCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let rightButton = UIBarButtonItem(
            image: UIImage(named:"NavBtnAdd"),
            style:.plain ,
            target:self ,
            action: #selector(ActivitiesViewController.addActivity))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(
            title: self.title,
            style: .plain,
            target: self,
            action: #selector(ActivitiesViewController.back))
        self.navigationItem.backBarButtonItem = backButton
        
        activities = category.activities
        
        let screenSize = UIScreen.main.bounds.size
        let tableViewHeight = screenSize.height - self.tabBarController!.tabBar.frame.height
        let tableView = UITableView(
            frame: CGRect(x: 0, y: 0, width: screenSize.width,height: tableViewHeight),
            style: .grouped)
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        self.tableView = tableView
        self.view.addSubview(tableView)
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CategoriesViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView!.addGestureRecognizer(longPressGesture)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addActivity() {
        let vc = EditActivityViewController(with: EditActivityModel.getNewActivityModel(), delegate: self)
        vc.title = "New Activity"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActivityTableViewCell
        let activity = activities![indexPath.section]
        cell.icon = activity.icon
        cell.name = activity.name
        return cell
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView!)
            if let indexPath = self.tableView!.indexPathForRow(at: touchPoint) {
                let activity = activities![indexPath.section]
                print("longPress: \(activity.name)")
                let vc = EditActivityViewController(
                    with: EditActivityModel.getEditActivityModel(from: activity as Object, name: activity.name, icon: activity.icon!),
                    delegate: self)
                vc.title = "Edit Activity"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let activity = activities![indexPath.section]
            print("delete \(activity.name)")
            let result = DatabaseModel.deleteActivity(activity)
            if !result {
                fatalError("delete Activity error")
            }
            self.tableView?.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activities!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 50
    }
    
    func didEditActivity(editActivityModel: EditActivityModel) {
        switch editActivityModel.type {
        case EditableActivityType.edit:
            let activity = editActivityModel.object as! Activity
            let result = DatabaseModel.updateActivity(activity, editActivityModel.name, editActivityModel.icon, category)
            if !result {
                fatalError("updateActivityCategory error")
            }
        case EditableActivityType.new:
            let result = DatabaseModel.addActivity(editActivityModel.name, editActivityModel.icon, category)
            if !result {
                fatalError("addActivityCategory error")
            }
        }
        activities = category.activities
        self.tableView?.reloadData()
    }
}
