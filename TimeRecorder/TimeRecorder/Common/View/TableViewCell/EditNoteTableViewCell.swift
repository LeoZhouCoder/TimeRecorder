//
//  EditTagTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditNoteTableViewCell: UITableViewCell {

    var title:String? {
        didSet {
            titleText.text = title

        }
    }
    
    var note: String? {
        didSet {
            noteText.text = note
        }
    }
    
    var titleText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    var noteText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleText)
        self.addSubview(noteText)
        
        NSLayoutConstraint.activate([
            titleText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleText.widthAnchor.constraint(equalToConstant: 100),
            titleText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor,
                                               constant: -(titleText.frame.size.height + noteText.frame.size.height)/2),
            
            noteText.leftAnchor.constraint(equalTo: titleText.leftAnchor),
            noteText.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            noteText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            noteText.widthAnchor.constraint(equalToConstant: 200),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
