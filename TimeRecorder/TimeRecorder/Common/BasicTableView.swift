//
//  BasicTableView.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/31.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit

class BasicTableView: UITableView {
    private let defaultPlaceHoderImage = "hg_default-no_results"
    private let defaultPlaceHoderTitle = "No results founds"
    private let defaultPlaceHoderSubtitle = "We can't find what you're looking for."
    
    private var placeHolderView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var placeHolderContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var placeHolderImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var placeHolderTitleTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        return textField
    }()
    
    private var placeHolderSubtitleTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    var placeHoderImage: UIImage?
    var placeHoderTitle: String?
    var placeHoderSubtitle: String?
    
    override func reloadData() {
        super.reloadData()
        checkEmpty()
    }
    
    private func checkEmpty() {
        var isEmpty = true
        for i in 0..<self.numberOfSections {
            if numberOfRows(inSection: i) > 0 {
                isEmpty = false
                break
            }
        }
        if isEmpty {
            showPlaceHoler()
        }else{
            placeHolderView.removeFromSuperview()
        }
    }
    
    private func showPlaceHoler() {
        
        placeHolderImageView.image = placeHoderImage ?? UIImage(named: defaultPlaceHoderImage)
        placeHolderTitleTextField.text = placeHoderTitle ?? defaultPlaceHoderTitle
        placeHolderSubtitleTextField.text = placeHoderSubtitle ?? defaultPlaceHoderSubtitle
        
        addSubview(placeHolderView)
        placeHolderView.addSubview(placeHolderContainer)
        placeHolderContainer.addSubview(placeHolderImageView)
        placeHolderContainer.addSubview(placeHolderTitleTextField)
        placeHolderContainer.addSubview(placeHolderSubtitleTextField)
        
        NSLayoutConstraint.activate([
            placeHolderView.heightAnchor.constraint(equalTo: self.heightAnchor),
            placeHolderView.widthAnchor.constraint(equalTo: self.widthAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            placeHolderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            placeHolderContainer.heightAnchor.constraint(equalToConstant: placeHolderImageView.height + placeHolderTitleTextField.height + placeHolderSubtitleTextField.height),
            placeHolderContainer.widthAnchor.constraint(equalTo: placeHolderView.widthAnchor),
            placeHolderContainer.centerYAnchor.constraint(equalTo: placeHolderView.centerYAnchor),
            placeHolderContainer.centerXAnchor.constraint(equalTo: placeHolderView.centerXAnchor),
            
            placeHolderImageView.centerXAnchor.constraint(equalTo: placeHolderContainer.centerXAnchor),
            placeHolderImageView.topAnchor.constraint(equalTo: placeHolderContainer.topAnchor),
            
            placeHolderTitleTextField.widthAnchor.constraint(equalTo: placeHolderView.widthAnchor),
            placeHolderTitleTextField.heightAnchor.constraint(equalToConstant: 30),
            placeHolderTitleTextField.topAnchor.constraint(equalTo: placeHolderImageView.bottomAnchor),
            placeHolderTitleTextField.centerXAnchor.constraint(equalTo: placeHolderContainer.centerXAnchor),
            
            placeHolderSubtitleTextField.widthAnchor.constraint(equalTo: placeHolderView.widthAnchor),
            placeHolderSubtitleTextField.heightAnchor.constraint(equalToConstant: 20),
            placeHolderSubtitleTextField.topAnchor.constraint(equalTo: placeHolderTitleTextField.bottomAnchor),
            placeHolderSubtitleTextField.centerXAnchor.constraint(equalTo: placeHolderContainer.centerXAnchor),
            ])
    }
}
