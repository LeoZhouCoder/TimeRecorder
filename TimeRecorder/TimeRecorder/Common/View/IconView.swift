//
//  IconView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/15.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class IconView: UICollectionViewCell {
    
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: frame)
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
