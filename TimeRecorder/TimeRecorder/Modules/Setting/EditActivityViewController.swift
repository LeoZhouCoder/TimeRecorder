//
//  EditItemViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit



class EditActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var info = ["name", "icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let rightButton = UIBarButtonItem(
            title: "Done",
            style:.done ,
            target:self ,
            action: #selector(EditActivityViewController.done))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(
            title: self.title,
            style: .plain,
            target: self,
            action: #selector(EditActivityViewController.back))
        self.navigationItem.backBarButtonItem = backButton
        
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
    
    @objc func done() {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    // get cell info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .disclosureIndicator
        if let label = cell.textLabel {
            label.text = "\(info[indexPath.row])"
        }
        return cell
    }
    
    // action when selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = info[indexPath.row]
        print("selected \(name)")
    }
    
    /*func tableView(_ tableView: UITableView, accessoryButtonTapped indexPath: IndexPath) {
     let name = info[indexPath.section][indexPath.row]
     print("selected \(name)")
     self.present(GroupEditViewController(), animated: true, completion: nil)
     }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
