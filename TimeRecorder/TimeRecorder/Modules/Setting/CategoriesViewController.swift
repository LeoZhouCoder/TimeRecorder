//
//  GroupEditViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories:Results<ActivityCategory>?

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        self.view.addSubview(tableView)
        
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addCategory() {
        let vc = EditActivityViewController()
        vc.title = "New Category"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // get cell info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .disclosureIndicator
        if let label = cell.textLabel {
            label.text = "\(categories![indexPath.section])"
        }
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     let name = info[indexPath.section][indexPath.row]
     print("delete \(name)")
     }
     }*/
    
    // action when selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = categories![indexPath.section]
        print("selected \(name)")
        
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 50
    }

}
