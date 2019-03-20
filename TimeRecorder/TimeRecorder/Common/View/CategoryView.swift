//
//  CategoryView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/20.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class CategoryView: UIView {

    var icon:Icon? {
        didSet {
            iconView.icon = icon
        }
    }
    
    var name:String? {
        didSet {
            nameText.text = name
        }
    }
    
    var iconView: IconView = {
        var iconView = IconView(frame: .zero)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    var nameText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(iconView)
        self.addSubview(nameText)
        NSLayoutConstraint.activate([
            //iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -iconView.frame.size.width * 0.5 - 50),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            iconView.widthAnchor.constraint(equalTo: self.iconView.heightAnchor),
            
            nameText.leftAnchor.constraint(equalTo: self.iconView.rightAnchor, constant: 10),
            nameText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameText.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -nameText.frame.origin.x - 10),
            nameText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
