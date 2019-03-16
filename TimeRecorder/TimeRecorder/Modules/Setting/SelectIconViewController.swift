//
//  SelectIconViewController.swift
//  TimeRecorder
//
//  Created by Leo Zhou on 2019/3/15.
//  Copyright © 2019 LeoZhou. All rights reserved.
//

import UIKit
import RealmSwift

class SelectIconViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var icons: Results<Icon>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "Select Icon"
        let screenSize = UIScreen.main.bounds.size
        
        icons = DatabaseModel.getAllIcons()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        //layout.minimumLineSpacing = 5
        let size = screenSize.width / 5
        layout.itemSize = CGSize(width : size, height : size)
        
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height),
            collectionViewLayout: layout)
        
        collectionView.register(IconView.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: "Cell", for: indexPath) as! IconView
        let icon = icons![indexPath.item]
        if icon.type == IconType.system.rawValue {
            cell.imageView.image = UIImage(named: icon.name)?.withRenderingMode(.alwaysTemplate)
        }else{
            cell.imageView.image = UIImage(data: icon.image)?.withRenderingMode(.alwaysTemplate)
        }
        cell.imageView.tintColor = UIView().tintColor!
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
    }
}
