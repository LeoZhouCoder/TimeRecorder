//
//  TCRecordList.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/23.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class RecordListTableViewCell: UITableViewCell {

    static func getBaseTextField(textColor: UIColor, fontSize: CGFloat = 0) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = textColor
        if fontSize != 0 {
            textField.font = UIFont.systemFont(ofSize: fontSize)
        }
        return textField
    }
    
    var record: ActivityRecord? {
        didSet {
            let format = "HH:mm:ss"
            startDateText.text = record?.startTime.toString(format: format)
            endDateText.text = record?.endTime!.toString(format: format)
            activityView.icon = record?.activity?.icon
            activityView.name = record?.activity?.name
            costTimeText.text = record?.endTime!.subtracted(earlierDate: record!.startTime, format: format)
            nodeText.text = record?.node
        }
    }
    
    var container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var activityView: CategoryView = {
        let activityView = CategoryView(frame: .zero)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    var startDateText: UITextField = getBaseTextField(textColor: UIColor.lightGray, fontSize: 10)
    
    var linkText: UITextField = {
        let textField = getBaseTextField(textColor: UIColor.lightGray, fontSize: 10)
        textField.text = "To"
        textField.textAlignment = .center
        return textField
    }()
    
    var endDateText: UITextField = getBaseTextField(textColor: UIColor.lightGray, fontSize: 10)
    
    var costTimeText: UITextField = getBaseTextField(textColor: UIColor.blue)
    
    var nodeText: UITextField = getBaseTextField(textColor: UIColor.lightGray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(container)
        container.addSubview(startDateText)
        container.addSubview(linkText)
        container.addSubview(endDateText)
        container.addSubview(activityView)
        container.addSubview(costTimeText)
        //costTimeText.backgroundColor = UIColor.red
        container.addSubview(nodeText)
        //nodeText.backgroundColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            startDateText.widthAnchor.constraint(equalToConstant: 50),
            startDateText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.3),
            startDateText.leftAnchor.constraint(equalTo: container.leftAnchor),
            startDateText.topAnchor.constraint(equalTo: container.topAnchor),
            
            linkText.widthAnchor.constraint(equalTo: startDateText.widthAnchor),
            linkText.heightAnchor.constraint(equalTo: startDateText.heightAnchor),
            linkText.leftAnchor.constraint(equalTo: startDateText.leftAnchor),
            linkText.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            endDateText.widthAnchor.constraint(equalTo: startDateText.widthAnchor),
            endDateText.heightAnchor.constraint(equalTo: startDateText.heightAnchor),
            endDateText.leftAnchor.constraint(equalTo: startDateText.leftAnchor),
            endDateText.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            activityView.widthAnchor.constraint(equalToConstant: 100),
            activityView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8),
            activityView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            activityView.leftAnchor.constraint(equalTo: startDateText.rightAnchor, constant: 10),
            
            costTimeText.widthAnchor.constraint(equalToConstant: 70),
            costTimeText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6),
            costTimeText.leftAnchor.constraint(equalTo: activityView.rightAnchor, constant: 10),
            costTimeText.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            nodeText.leftAnchor.constraint(equalTo: costTimeText.rightAnchor, constant: 10),
            nodeText.widthAnchor.constraint(equalToConstant: 100),
            nodeText.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8),
            nodeText.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
