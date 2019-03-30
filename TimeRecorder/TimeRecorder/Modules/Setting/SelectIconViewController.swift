//
//  SelectIconViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/15.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

protocol SelectIconViewProtocol {
    func didSelectIcon(_ icon:Icon)
}

class SelectIconViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var selectedIcon:Icon
    var icons: Results<Icon>?
    var delegate: SelectIconViewProtocol
    
    init(selectedIcon: Icon, delegate: SelectIconViewProtocol) {
        self.selectedIcon = selectedIcon
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "Select Icon"
        let screenSize = UIScreen.main.bounds.size
        
        icons = DataManager.shareManager.getIcons()
        
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 5
        let defaultSize: CGFloat = IconViewCell.defaultSize
        let cellNumPerRow = CGFloat(Int(screenSize.width / defaultSize))
        let size = (screenSize.width - (cellNumPerRow + 1) * space) / cellNumPerRow
        layout.itemSize = CGSize(width : size, height : size)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height),
            collectionViewLayout: layout)
        
        collectionView.register(IconViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IconViewCell
        let icon = icons![indexPath.item]
        cell.icon = icons![indexPath.item]
        cell.isSelected = icon.name == self.selectedIcon.name
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.didSelectIcon(icons![indexPath.item])
    }
}
