//
//  EditItemViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/14.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

enum EditableActivityAttribute: String {
    case name = "Name"
    case icon = "Icon"
}

enum EditableActivityType {
    case new, edit
}

struct EditActivityModel {
    var name: String
    var icon: Icon
    var type: EditableActivityType
    var object: Object?
    
    static func getNewActivityModel() -> EditActivityModel {
        let model = EditActivityModel(name: "",
                                      icon: DataManager.shareManager.defaultIcon!,
                                      type: EditableActivityType.new,
                                      object: nil)
        return model
    }
    
    static func getEditActivityModel(from object:Object, name:String, icon:Icon) -> EditActivityModel {
        let model = EditActivityModel(name: name,
                                      icon: icon,
                                      type: EditableActivityType.edit,
                                      object: object)
        return model
    }
}

protocol EditActivityViewProtocol {
    func didEditActivity(editActivityModel:EditActivityModel)
}

class EditActivityViewController: BasicTableViewController, SelectIconViewProtocol, EditActivityNameProtocol {
    
    let attributes = [EditableActivityAttribute.name, EditableActivityAttribute.icon]
    
    var editActivityModel:EditActivityModel
    var delegate: EditActivityViewProtocol?
    var iconCellIndex: IndexPath?
    
    init(with model: EditActivityModel, delegate: EditActivityViewProtocol?) {
        self.editActivityModel = model
        super.init(title: "", showTabBar: false)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.register(EditActivityNameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView!.register(EditActivityIconTableViewCell.self, forCellReuseIdentifier: "IconCell")
        
        let rightButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(EditActivityViewController.done))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(EditActivityViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func done() {
        self.view.endEditing(true)
        self.delegate?.didEditActivity(editActivityModel: editActivityModel)
        self.back()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attribute = attributes[indexPath.row]
        switch attribute {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! EditActivityNameTableViewCell
            if let label = cell.textLabel {
                label.text = attributes[indexPath.row].rawValue
            }
            cell.delegate = self
            cell.name = editActivityModel.name
            return cell
        case .icon:
            iconCellIndex = indexPath
            let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as! EditActivityIconTableViewCell
            cell.accessoryType = .disclosureIndicator
            if let label = cell.textLabel {
                label.text = attributes[indexPath.row].rawValue
            }
            cell.icon = editActivityModel.icon
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
                SelectIconViewController(selectedIcon: editActivityModel.icon, delegate: self),
                animated: true)
        }
    }
    
    func didSelectIcon(_ icon: Icon) {
        editActivityModel.icon = icon
        self.navigationController?.popViewController(animated: true)
        if let indexPath = iconCellIndex {
            let cell = tableView!.cellForRow(at: indexPath) as! EditActivityIconTableViewCell
            cell.icon = icon
        }
    }
    
    func didEndEditing(name: String) {
        editActivityModel.name = name
    }
    
}
