//
//  SettingViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class SettingViewController: BasicTableViewController  {

    // Setting page items, currently only one option: edit Categories
    var info = ["Categories"] // Category
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .disclosureIndicator
        if let label = cell.textLabel {
            label.text = "\(info[indexPath.row])"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = info[indexPath.row]
        switch name {
        case "Categories":
            let vc = CategoriesViewController(title: name, showTabBar: false)
            vc.title = name
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            fatalError("SettingViewController \(name)'s select action has not been implemented")
        }
    }
    
}
