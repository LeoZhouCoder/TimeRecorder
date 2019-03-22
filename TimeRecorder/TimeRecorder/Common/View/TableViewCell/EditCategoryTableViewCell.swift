//
//  EditCategoryTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class EditCategoryTableViewCell: UITableViewCell {

    var title:String? {
        didSet {
            titleText.text = title
        }
    }
    
    var activity: Activity? {
        didSet {
            if let currentActivity = activity {
                let category = currentActivity.category
                categoryView.icon = category!.icon
                categoryView.name = category!.name
                activityView.icon = currentActivity.icon
                activityView.name = currentActivity.name
            }
        }
    }
    
    var titleText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    var categoryView: CategoryView = {
        let categoryView = CategoryView(frame: .zero)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    var linkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TabTimer"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var activityView: CategoryView = {
        let activityView = CategoryView(frame: .zero)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleText)
        self.addSubview(categoryView)
        self.addSubview(linkImageView)
        self.addSubview(activityView)
        
        NSLayoutConstraint.activate([
            titleText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleText.widthAnchor.constraint(equalToConstant: 100),
            titleText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleText.centerXAnchor.constraint(equalTo: self.centerXAnchor,
                                               constant: -(titleText.frame.size.height + categoryView.frame.size.height)/2),
            
            categoryView.leftAnchor.constraint(equalTo: titleText.leftAnchor),
            categoryView.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            categoryView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            categoryView.widthAnchor.constraint(equalToConstant: 100),
            
            linkImageView.leftAnchor.constraint(equalTo: categoryView.rightAnchor, constant: 10),
            linkImageView.heightAnchor.constraint(equalTo: categoryView.heightAnchor),
            linkImageView.widthAnchor.constraint(equalTo: linkImageView.heightAnchor),
            linkImageView.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            
            activityView.widthAnchor.constraint(equalTo: categoryView.widthAnchor),
            activityView.heightAnchor.constraint(equalTo: categoryView.heightAnchor),
            activityView.leftAnchor.constraint(equalTo: linkImageView.rightAnchor, constant: 10),
            activityView.centerYAnchor.constraint(equalTo: linkImageView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
