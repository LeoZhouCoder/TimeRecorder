//
//  TimerViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/13.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Timer"
        let screenSize = UIScreen.main.bounds.size
        let picker = TRCategoryPicker(frame: CGRect(x: 0, y: 200, width: screenSize.width, height: screenSize.height * 0.4), delegate: nil)
        self.view.addSubview(picker)
    }
}
