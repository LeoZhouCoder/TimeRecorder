//
//  EditActivityNameCellTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

protocol EditActivityNameProtocol {
    func didEndEditing(name:String)
}

class EditActivityNameTableViewCell: UITableViewCell, UITextFieldDelegate {

    var delegate: EditActivityNameProtocol?
    var name: String? {
        didSet {
            nameText.text = name
        }
    }
    
    var nameText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Please enter a name"
        textField.clearButtonMode = .always
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.textColor = UIColor.black
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameText)
        nameText.delegate = self
        NSLayoutConstraint.activate([
            nameText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 80),
            nameText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            nameText.heightAnchor.constraint(equalTo: self.textLabel!.heightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let myDelegate = self.delegate {
            myDelegate.didEndEditing(name: textField.text!)
        }
    }
}
