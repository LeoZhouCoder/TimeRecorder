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
    case note = "Note"
}

enum EditRecordType: String {
    case new = "New Record"
    case modify = "Edit Record"
}

struct EditRecordModel {
    var editType: EditRecordType
    var activity: Activity
    var startDate: Date
    var endDate: Date
    var node: String?
    var record:ActivityRecord?
}

protocol EditRecordViewProtocol {
    func didEditRecord(editRecordModel:EditRecordModel)
}

class EditRecordViewController: BaseEditAttributeTableViewController, UITextFieldDelegate, TRCategoryPickerProtocol, TRDatePickerProtocol {
    
    var editList = [
        EditableRecordAttribute.category,
        EditableRecordAttribute.startDate,
        EditableRecordAttribute.endDate,
        EditableRecordAttribute.note
    ]
    var model:EditRecordModel
    var delegate: EditRecordViewProtocol?
    
    var categoryPicker: TRCategoryPicker?
    var datePicker: TRDatePicker?
    
    init(with record: ActivityRecord?, delegate: EditRecordViewProtocol?) {
        var model: EditRecordModel
        var title: String
        if let currentRecord = record {
            model = EditRecordModel(editType: EditRecordType.modify,
                                    activity: currentRecord.activity!,
                                    startDate: currentRecord.startTime,
                                    endDate: currentRecord.endTime,
                                    node: currentRecord.tag,
                                    record: currentRecord)
        }else{
            model = EditRecordModel(editType: EditRecordType.new,
                                    activity: DatabaseModel.getAllActivities()[0],
                                    startDate: Date(),
                                    endDate: Date(),
                                    node: "",
                                    record: nil)
        }
        title = model.editType.rawValue
        self.model = model
        super.init(title: title, showTabBar: false)
        self.delegate = delegate
        
        attributes = [
            AttributeDate(name: EditableRecordAttribute.category.rawValue, type: AttributeType.category),
            AttributeDate(name: EditableRecordAttribute.startDate.rawValue, type: AttributeType.date),
            AttributeDate(name: EditableRecordAttribute.endDate.rawValue, type: AttributeType.date),
            AttributeDate(name: EditableRecordAttribute.note.rawValue, type: AttributeType.note)]
        
        let categoryPicker = TRCategoryPicker(frame: .zero, delegate: self)
        view.addSubview(categoryPicker)
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.isHidden = true
        NSLayoutConstraint.activate([
            categoryPicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            categoryPicker.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            categoryPicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        self.categoryPicker = categoryPicker
        
        let datePicker =  TRDatePicker(frame: .zero, delegate: self)
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isHidden = true
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            datePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            datePicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        self.datePicker = datePicker
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
    
    override func setCellDate(cellForRowAt indexPath: IndexPath, cell: BaseEditRecordTableViewCell) -> BaseEditRecordTableViewCell {
        let attribute = attributes[indexPath.row]
        cell.title = attribute.name
        switch attribute.name {
        case EditableRecordAttribute.category.rawValue:
            let categoryCell = cell as! EditCategoryTableViewCell
            categoryCell.activity = model.activity
        case EditableRecordAttribute.startDate.rawValue:
            let startDateCell = cell as! EditDateTableViewCell
            startDateCell.date = model.startDate
        case EditableRecordAttribute.endDate.rawValue:
            let startDateCell = cell as! EditDateTableViewCell
            startDateCell.date = model.endDate
        case EditableRecordAttribute.note.rawValue:
            let noteCell = cell as! EditNoteTableViewCell
            noteCell.note = model.node
            noteCell.noteTextDelegate = self
        default:
            print("implemented")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let attribute = attributes[indexPath.row]
        //let cell = tableView.cellForRow(at: indexPath)
        switch attribute.name {
        case EditableRecordAttribute.category.rawValue:
            showCategoryPicker()
        case EditableRecordAttribute.startDate.rawValue:
            showDatePicker(attribute: attribute)
        case EditableRecordAttribute.endDate.rawValue:
            showDatePicker(attribute: attribute)
        case EditableRecordAttribute.note.rawValue:
            //let noteCell = cell as! EditNoteTableViewCell
            //noteCell.note = "Test note."
            self.categoryPicker?.isHidden = true
            self.datePicker?.isHidden = true
            print("Add delegate to cell")
        default:
            print("implemented")
        }
    }
    
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func showCategoryPicker() {
        self.categoryPicker?.isHidden = false
        self.datePicker?.isHidden = true
    }
    
    func didPickActivity(activity: Activity, isClosed: Bool) {
        //let attribute = attributes[indexPath.row]
        print("didPickActivity \(activity.name) isClosed: \(isClosed)")
        let categoryCell = tableView!.cellForRow(at: tableView!.indexPathForSelectedRow!) as! EditCategoryTableViewCell
        categoryCell.activity = activity
        model.activity = activity
        if(isClosed) {
            self.categoryPicker?.isHidden = true
        }
    }
    
    func showDatePicker(attribute: AttributeDate) {
        self.datePicker?.isHidden = false
        self.categoryPicker?.isHidden = true
        switch attribute.name {
        case EditableRecordAttribute.startDate.rawValue:
            self.datePicker?.date = model.startDate
            self.datePicker?.minimumDate = nil
            self.datePicker?.maximumDate = model.endDate
        case EditableRecordAttribute.endDate.rawValue:
            self.datePicker?.date = model.endDate
            self.datePicker?.minimumDate = model.startDate
            self.datePicker?.maximumDate = nil
        default:
            print(attribute.name)
        }
    }
    
    func didPickDate(date: Date, isClosed: Bool) {
        print("didPickDate \(date) isClosed: \(isClosed)")
        let indexPath = tableView!.indexPathForSelectedRow!
        let dateCell = tableView!.cellForRow(at: indexPath) as! EditDateTableViewCell
        dateCell.date = date
        let attribute = attributes[indexPath.row]
        
        switch attribute.name {
        case EditableRecordAttribute.startDate.rawValue:
            model.startDate = date
        case EditableRecordAttribute.endDate.rawValue:
            model.endDate = date
        default:
            print("didPickDate \(attribute.name)")
        }
        
        if(isClosed) {
            self.datePicker?.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.node = textField.text
        print("Node: \(model.node!)")
    }
    
    @objc func done() {
        self.view.endEditing(true)
        self.delegate?.didEditRecord(editRecordModel: model)
        self.back()
    }
}
