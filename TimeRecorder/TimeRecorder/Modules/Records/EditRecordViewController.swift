//
//  EditRecordViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/20.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit


enum EditableRecordAttribute: String {
    case category = "Category"
    case startDate = "StartDate"
    case endDate = "EndDate"
    case tag = "Tag"
}

enum EditRecordType {
    case new, modify
}

struct EditRecordModel {
    var editType: EditRecordType
    var record:ActivityRecord?
}

protocol EditRecordViewProtocol {
    func didEditRecord(editRecordModel:EditRecordModel)
}

class EditRecordViewController: BasicTableViewController {

    var editList = [
        EditableRecordAttribute.category,
        EditableRecordAttribute.startDate,
        EditableRecordAttribute.endDate,
        EditableRecordAttribute.tag
    ]
    var model:EditRecordModel
    var delegate: EditRecordViewProtocol?
    
    init(with record: ActivityRecord?, delegate: EditRecordViewProtocol?) {
        
        var model: EditRecordModel
        var title: String
        if let currentRecord = record {
            model = EditRecordModel(editType: EditRecordType.modify, record: currentRecord)
            title = "Edit Record"
        }else{
            model = EditRecordModel(editType: EditRecordType.new, record: nil)
            title = "New Record"
        }
        self.model = model
        super.init(title: title, showTabBar: false)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(EditRecordViewController.done))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(EditRecordViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func done() {
        self.view.endEditing(true)
        self.delegate?.didEditRecord(editRecordModel: model)
        self.back()
    }
}
