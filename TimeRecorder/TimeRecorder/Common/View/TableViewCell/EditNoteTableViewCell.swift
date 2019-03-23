//
//  EditTagTableViewCell.swift
//  TimeRecorder
//  Task:
//      System font?
//      Selected state?
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditNoteTableViewCell: BaseEditRecordTableViewCell {

    var note: String? {
        didSet {
            noteText.text = note
        }
    }
    
    var noteTextDelegate: UITextFieldDelegate? {
        didSet {
            noteText.delegate = noteTextDelegate
        }
    }
    
    private var noteText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        textField.placeholder = "Add some note"
        textField.clearButtonMode = .always
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        container.addSubview(noteText)
        
        NSLayoutConstraint.activate([
            noteText.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            noteText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.65),
            noteText.widthAnchor.constraint(equalTo: container.widthAnchor)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        noteText.isUserInteractionEnabled = selected
        if selected {
            noteText.becomeFirstResponder()
        }
    }

}
