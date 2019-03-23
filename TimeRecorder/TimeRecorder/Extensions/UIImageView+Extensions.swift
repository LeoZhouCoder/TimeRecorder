//
//  UIImageView+Extensions.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
