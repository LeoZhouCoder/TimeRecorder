//
//  IconView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    var icon:Icon? {
        didSet {
            if let currentIcon = icon {
                if currentIcon.type == IconType.system.rawValue {
                    self.backgroundColor = self.tintColor
                    imageView.image = UIImage(named: currentIcon.name)
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
                        ])
                }else{
                    self.backgroundColor = UIColor.white
                    imageView.image = UIImage(data: currentIcon.image)
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
                        ])
                }
            }else{
                imageView.image = nil
            }
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            ])
        self.layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width * 0.5
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
