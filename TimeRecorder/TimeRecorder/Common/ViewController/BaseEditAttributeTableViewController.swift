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
        case .category: return EditActivityIconTableViewCell.self
        case .date: return EditActivityIconTableViewCell.self
        case .note: return EditActivityIconTableViewCell.self
        }
    }
}

struct AttributeDate {
    let name: String
    let title: String
    let type: AttributeType
}

class BaseEditAttributeTableViewController: BasicTableViewController {

    var attributes:[AttributeDate] = [
        AttributeDate(name: "category", title: "Category", type: AttributeType.category),
        AttributeDate(name: "startDate", title: "StartDate", type: AttributeType.date),
        AttributeDate(name: "endDate", title: "EndDate", type: AttributeType.date),
        AttributeDate(name: "note", title: "Note", type: AttributeType.note)]
    
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attribute = attributes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: attribute.type.rawValue, for: indexPath) as UITableViewCell
        return setCellDate(cellForRowAt: indexPath, cell: cell)
    }
    
    // override this function to set cell date
    func setCellDate(cellForRowAt indexPath: IndexPath, cell: UITableViewCell) -> UITableViewCell {
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let category = categories![indexPath.row]
        //let vc = ActivitiesViewController(with: category, title: "Activities", showTabBar: false)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}
