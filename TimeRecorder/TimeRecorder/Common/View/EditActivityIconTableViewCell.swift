//
//  EditActivityIconTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditActivityIconTableViewCell: UITableViewCell {

    var icon:Icon? {
        didSet{
            iconView.icon = icon
            
        }
    }
    var iconView: IconView = {
        var iconView = IconView(frame: .zero)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 80),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
