//
//  EditDateTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditDateTableViewCell: BaseEditRecordTableViewCell {

    var date: Date? {
        didSet {
            // 判断日期是今天
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateText.text = formatter.string(from: date!)
        }
    }
    
    var dateText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        container.addSubview(dateText)
        
        NSLayoutConstraint.activate([
            dateText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.65),
            dateText.widthAnchor.constraint(equalTo: container.widthAnchor),
            dateText.leftAnchor.constraint(equalTo: titleText.leftAnchor),
            dateText.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
