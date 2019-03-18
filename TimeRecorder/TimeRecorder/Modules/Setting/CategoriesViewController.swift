//
//  GroupEditViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditActivityViewProtocol, UIGestureRecognizerDelegate {
    
    var categories: Results<ActivityCategory>?
    var tableView: UITableView?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let rightButton = UIBarButtonItem(
         image: UIImage(named:"NavBtnAdd"),
         style:.plain ,
         target:self ,
         action: #selector(CategoriesViewController.addCategory))
         self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(
            title: self.title,
            style: .plain,
            target: self,
            action: #selector(CategoriesViewController.back))
        self.navigationItem.backBarButtonItem = backButton
        
        // show all Categories
        categories = DatabaseModel.getAllActivityCategory()
        
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
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.tableView!.addGestureRecognizer(longPressGesture)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addCategory() {
        let vc = EditActivityViewController(with: nil, delegate: self)
        vc.title = "New Category"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // get cell info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActivityTableViewCell
        cell.accessoryType = .disclosureIndicator
        let category = categories![indexPath.section]
        cell.icon = category.icon
        cell.name = category.name
        return cell
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView!)
            if let indexPath = self.tableView!.indexPathForRow(at: touchPoint) {
                let category = categories![indexPath.section]
                print("longPress: \(category.name)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = categories![indexPath.section]
            print("delete \(category.name)")
        }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories![indexPath.section]
        print("selected \(category.name)")
        //self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
    
    /*func tableView(_ tableView: UITableView, accessoryButtonTapped indexPath: IndexPath) {
     let name = info[indexPath.section][indexPath.row]
     print("selected \(name)")
     self.present(GroupEditViewController(), animated: true, completion: nil)
     }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories!.count
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
        print("New Category name: \(editActivityModel.name) icon: \(editActivityModel.icon)")
        let result = DatabaseModel.addActivityCategory(editActivityModel.name, editActivityModel.icon)
        if result {
            self.tableView?.reloadData()
        }
    }
    

}
