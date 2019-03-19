//
//  FilteStateView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/18.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
enum SeleteState {
    case none
    case part
    case all
}
class FilteStateView: UIView {

    var state: SeleteState? {
        didSet {
            switch state! {
            case .none:
                imageView.isHidden = true
                self.backgroundColor = UIColor.white
                self.layer.borderColor = UIColor.black.cgColor
            case .part:
                imageView.isHidden = false
                self.backgroundColor = UIColor.lightGray
                self.layer.borderColor = UIColor.lightGray.cgColor
            case .all:
                imageView.isHidden = false
                self.backgroundColor = self.tintColor
                self.layer.borderColor = self.tintColor.cgColor
            }
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "NavBtnAdd"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            ])
        self.backgroundColor = UIColor.red
        self.layer.masksToBounds = true
        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.size.width * 0.5
        
        self.state = SeleteState.all
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
