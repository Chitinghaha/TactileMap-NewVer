//
//  HomePageMapInfoTableViewCell.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

class HomePageMapInfoTableViewCell: UITableViewCell {
        
    var mapInfoListCollectionView: MapInfoListCollectionView!
    
    var mapsInfo: [Map]?
    
    var coordinator: MapInfoListCollectionViewCoordinator!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mapInfoListCollectionView = MapInfoListCollectionView.loadFromNib()
        self.addSubview(self.mapInfoListCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mapInfoListCollectionView.frame = self.contentView.bounds
        self.mapInfoListCollectionView.coordinator = self.coordinator

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: (self.mapInfoListCollectionView.frame.size.width - 100) / 3, height: self.mapInfoListCollectionView.frame.height)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 50)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 50)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.mapInfoListCollectionView.collectionViewLayout = layout
        self.mapInfoListCollectionView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
    }
    
    func setupMapInfoListModel(mapsInfo: [Map] ) {
        self.mapsInfo = mapsInfo
        self.mapInfoListCollectionView.setUp(mapsInfo: self.mapsInfo!)
        self.mapInfoListCollectionView.setupBinding()
    }
}
