//
//  TRDatePicker.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/17.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

protocol TRDatePickerProtocol {
    func didPickDate(date: Date, isClosed: Bool)
}

class TRDatePicker: UIView {

    var delegate: TRDatePickerProtocol?
    var closeButton: UIButton
    var datePicker: UIDatePicker
    
    init(frame: CGRect, delegate: TRDatePickerProtocol?) {
        
        closeButton = UIButton(type: .custom)
        datePicker = UIDatePicker(frame: .zero)
        
        super.init(frame: frame)
        
        self.delegate = delegate
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.layer.cornerRadius = 2
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named:"NavBtnAdd"), for: .normal)
        closeButton.backgroundColor = UIColor.lightGray
        closeButton.addTarget(self, action: #selector(TRDatePicker.close), for: .touchUpInside)
        addSubview(closeButton)
        
        let borderWidth: CGFloat = 2
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.layer.masksToBounds = true
        datePicker.layer.borderColor = UIColor.lightGray.cgColor
        datePicker.layer.borderWidth = borderWidth
        datePicker.datePickerMode = .dateAndTime
        datePicker.minuteInterval = 1
        datePicker.backgroundColor = UIColor.white
        datePicker.date = Date()
        datePicker.addTarget(self,
                             action:#selector(TRDatePicker.datePickerChanged),
                             for: .valueChanged)
        addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor),
            
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            datePicker.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 2 * borderWidth),
            datePicker.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -closeButton.frame.height)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func close() {
        self.delegate?.didPickDate(date: datePicker.date, isClosed: true)
    }
    
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        self.delegate?.didPickDate(date: datePicker.date, isClosed: false)
    }
    
    deinit {
        print("TRDatePicker is being deinitialized")
    }
}
