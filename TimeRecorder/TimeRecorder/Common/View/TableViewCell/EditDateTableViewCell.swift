//
//  EditDateTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditDateTableViewCell: UITableViewCell {

    var title:String? {
        didSet {
            titleText.text = title
        }
    }
    
    var date: Date? {
        didSet {
            // 判断日期是今天
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateText.text = formatter.string(from: date!)
        }
    }
    
    var titleText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    var dateText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleText)
        self.addSubview(dateText)
        
        NSLayoutConstraint.activate([
            titleText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleText.widthAnchor.constraint(equalToConstant: 100),
            titleText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor,
                                               constant: -(titleText.frame.size.height + dateText.frame.size.height)/2),
            
            dateText.leftAnchor.constraint(equalTo: titleText.leftAnchor),
            dateText.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            dateText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            dateText.widthAnchor.constraint(equalToConstant: 200),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
