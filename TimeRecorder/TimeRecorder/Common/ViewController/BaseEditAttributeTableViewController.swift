//
//  BaseEditAttributeTableViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/21.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

enum AttributeType:String {
    case category = "CategoryCell"
    case date = "DateCell"
    case note = "NoteCell"
    var cellClass: AnyClass {
        switch self {
        case .category: return EditCategoryTableViewCell.self
        case .date: return EditDateTableViewCell.self
        case .note: return EditNoteTableViewCell.self
        }
    }
}

struct AttributeDate {
    let name: String
    let type: AttributeType
}

class BaseEditAttributeTableViewController: BasicTableViewController {

    var attributes:[AttributeDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var registerCells:[AttributeType] = []
        for attribute in attributes {
            if registerCells.contains(attribute.type) {
                continue
            }
            registerCells.append(attribute.type)
            tableView?.register(attribute.type.cellClass, forCellReuseIdentifier: attribute.type.rawValue)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attribute = attributes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: attribute.type.rawValue, for: indexPath) as! BaseEditRecordTableViewCell
        return setCellDate(cellForRowAt: indexPath, cell: cell)
    }
    
    // override this function to set cell date
    func setCellDate(cellForRowAt indexPath: IndexPath, cell: BaseEditRecordTableViewCell) -> UITableViewCell {
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        return 70
    }
}
