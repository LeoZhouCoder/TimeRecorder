//
//  EditCategoryTableViewCell.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/22.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
class EditCategoryTableViewCell: BaseEditRecordTableViewCell {
    
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
    
    var categoryView: CategoryView = {
        let categoryView = CategoryView(frame: .zero)
        //categoryView.backgroundColor = UIColor.yellow
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    var linkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IconArrowForward"))
        //imageView.backgroundColor = UIColor.brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setImageColor(color: UIColor.lightGray)
        return imageView
    }()
    
    var activityView: CategoryView = {
        let activityView = CategoryView(frame: .zero)
        //activityView.backgroundColor = UIColor.red
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        container.addSubview(categoryView)
        container.addSubview(linkImageView)
        container.addSubview(activityView)
        
        NSLayoutConstraint.activate([
            categoryView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.65),
            categoryView.widthAnchor.constraint(equalToConstant: 80),
            categoryView.leftAnchor.constraint(equalTo: titleText.leftAnchor),
            categoryView.topAnchor.constraint(equalTo: titleText.bottomAnchor),
            
            linkImageView.heightAnchor.constraint(equalTo: categoryView.heightAnchor, multiplier: 0.5),
            linkImageView.widthAnchor.constraint(equalTo: linkImageView.heightAnchor),
            linkImageView.leftAnchor.constraint(equalTo: categoryView.rightAnchor, constant: 10),
            linkImageView.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
            
            activityView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5),
            activityView.heightAnchor.constraint(equalTo: categoryView.heightAnchor),
            activityView.leftAnchor.constraint(equalTo: linkImageView.rightAnchor, constant: 10),
            activityView.centerYAnchor.constraint(equalTo: linkImageView.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
