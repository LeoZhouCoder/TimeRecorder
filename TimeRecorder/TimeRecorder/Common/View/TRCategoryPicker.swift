//
//  TRCategoryPicker.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/20.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

protocol TRCategoryPickerProtocol {
    func didPickActivity(activity: Activity, isClosed: Bool)
}

class TRCategoryPicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: TRCategoryPickerProtocol?
    var closeButton: UIButton
    var picker: UIPickerView
    var categories: Results<ActivityCategory>?
    var categoryIndex = 0
    
    init(frame: CGRect, delegate: TRCategoryPickerProtocol?) {
        
        closeButton = UIButton(type: .custom)
        picker = UIPickerView(frame: .zero)
        
        super.init(frame: frame)
        
        //self.backgroundColor = UIColor.white
        self.delegate = delegate
        
        categories = DataManager.shareManager.getActivityCategories()
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.layer.cornerRadius = 2
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named:"NavBtnAdd"), for: .normal)
        closeButton.backgroundColor = UIColor.lightGray
        closeButton.addTarget(self, action: #selector(TRCategoryPicker.close), for: .touchUpInside)
        addSubview(closeButton)
        
        let borderWidth: CGFloat = 2
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor.white
        picker.layer.masksToBounds = true
        picker.layer.borderColor = UIColor.lightGray.cgColor
        picker.layer.borderWidth = borderWidth
        picker.delegate = self
        picker.dataSource = self
        addSubview(picker)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor),
            
            picker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            picker.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            picker.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 2 * borderWidth),
            picker.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -closeButton.frame.height)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func close() {
        let activity = categories![categoryIndex].activities[picker.selectedRow(inComponent: 1)]
        self.delegate?.didPickActivity(activity: activity, isClosed: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? categories!.count : categories![categoryIndex].activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            categoryIndex = row
            picker.reloadComponent(1)
        }
        let activity = categories![categoryIndex].activities[picker.selectedRow(inComponent: 1)]
        //print("Selected activity: \(activity)")
        self.delegate?.didPickActivity(activity: activity, isClosed: false)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let categoryView = CategoryView(frame: .zero)
        if component == 0 {
            let category = categories![row]
            categoryView.icon = category.icon
            categoryView.name = category.name
        }else{
            let activity = categories![categoryIndex].activities[row]
            categoryView.icon = activity.icon
            categoryView.name = activity.name
        }
        return categoryView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    deinit {
        print("TRDatePicker is being deinitialized")
    }
}
