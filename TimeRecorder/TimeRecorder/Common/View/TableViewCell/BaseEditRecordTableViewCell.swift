//
//  BaseEditRecordTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class BaseEditRecordTableViewCell: UITableViewCell {

    var title:String? {
        didSet {
            titleText.text = title
        }
    }
    
    open var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open var titleText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = UIColor.lightGray
        textField.font = UIFont.systemFont(ofSize: 10)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(container)
        container.addSubview(titleText)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleText.textColor = selected ? self.tintColor : UIColor.lightGray
    }
}
