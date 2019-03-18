//
//  IconView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/15.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
class IconViewCell: UICollectionViewCell {
    
    static let defaultSize: CGFloat = 70
    static let systemBlueColor = UIView().tintColor!
    
    var icon: Icon? {
        didSet {
            iconView.icon = icon
        }
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.lightGray : UIColor.white
        }
    }
    var iconView:IconView
    
    override init(frame: CGRect) {
        self.iconView = IconView(frame: .zero)
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //self.layer.borderWidth = 1
        self.layer.cornerRadius = frame.height / 16
        self.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
