//
//  BasicShowItemsTableViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/19.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class BasicItemsTableViewController: BasicTableViewController, UIGestureRecognizerDelegate {

    var itemName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(
            image: UIImage(named:"NavBtnAdd"),
            style:.plain ,
            target:self ,
            action: #selector(BasicItemsTableViewController.tappedAddButton))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CategoriesViewController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView!.addGestureRecognizer(longPressGesture)
    }
    
    @objc func tappedAddButton() {
        
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView!)
            if let indexPath = self.tableView!.indexPathForRow(at: touchPoint) {
                longPressRow(at: indexPath)
            }
        }
    }
    
    func longPressRow(at indexPath:IndexPath) {
        
    }

}
