//
//  TRDatePicker.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/17.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class TRDatePicker: UIView {

    var datePicker: UIDatePicker
    override init(frame: CGRect) {
        
        datePicker = UIDatePicker(frame: frame)
        
        super.init(frame: frame)
        
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 1
        datePicker.date = Date()
        
        // 設置 NSDate 的格式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        //datePicker.minimumDate = formatter.date(from: "2016-01-02 18:08")
        //datePicker.maximumDate = formatter.date(from: "2017-12-25 10:45")
        //datePicker.locale = Locale(identifier: "zh_CN")
        
        datePicker.addTarget(self,
                             action:#selector(TRDatePicker.datePickerChanged),
                             for: .valueChanged)
        
        datePicker.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        addSubview(datePicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        print(formatter.string(from: datePicker.date))
    }
}
