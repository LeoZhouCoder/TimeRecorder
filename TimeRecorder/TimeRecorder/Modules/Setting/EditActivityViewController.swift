//
//  EditItemViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

enum EditableActivityAttribute: String {
    case name = "Name"
    case icon = "Icon"
}

struct EditActivityModel {
    var name: String
    var icon: Icon
}

protocol EditActivityViewProtocol {
    func didEditActivity(editActivityModel:EditActivityModel)
}

class EditActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectIconViewProtocol, EditActivityNameProtocol {
    
    let attributes = [EditableActivityAttribute.name, EditableActivityAttribute.icon]
    
    var editActivityModel:EditActivityModel?
    var delegate: EditActivityViewProtocol?
    var tableView: UITableView?
    var iconCellIndex: IndexPath?
    
    init(with model: EditActivityModel?, delegate: EditActivityViewProtocol?) {
        super.init(nibName: nil, bundle: nil)
        if model == nil {
            self.editActivityModel = EditActivityModel(name: "", icon: DatabaseModel.getDefaultIcon())
        }else{
            self.editActivityModel = model
        }
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.register(EditActivityNameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(EditActivityIconTableViewCell.self, forCellReuseIdentifier: "IconCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        
        self.view.addSubview(tableView)
        self.tableView = tableView
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(EditActivityViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func done() {
        self.view.endEditing(true)
        self.delegate?.didEditActivity(editActivityModel: editActivityModel!)
        self.back()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attribute = attributes[indexPath.row]
        switch attribute {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! EditActivityNameTableViewCell
            if let label = cell.textLabel {
                label.text = "\(attributes[indexPath.row].rawValue)"
            }
            cell.delegate = self
            cell.name = editActivityModel!.name
            return cell
        case .icon:
            iconCellIndex = indexPath
            let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as! EditActivityIconTableViewCell
            cell.accessoryType = .disclosureIndicator
            if let label = cell.textLabel {
                label.text = "\(attributes[indexPath.row].rawValue)"
            }
            cell.icon = editActivityModel!.icon
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attribute = attributes[indexPath.row]
        switch attribute {
        case .name:
            print("selected \(attribute)")
        case .icon:
            self.navigationController?.pushViewController(
                SelectIconViewController(selectedIcon: editActivityModel!.icon, delegate: self),
                animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 50
    }
    
    func didSelectIcon(_ icon: Icon) {
        editActivityModel!.icon = icon
        self.navigationController?.popViewController(animated: true)
        if let indexPath = iconCellIndex {
            let cell = tableView!.cellForRow(at: indexPath) as! EditActivityIconTableViewCell
            cell.icon = icon
        }
    }
    
    func didEndEditing(name: String) {
        editActivityModel!.name = name
    }
    
}
