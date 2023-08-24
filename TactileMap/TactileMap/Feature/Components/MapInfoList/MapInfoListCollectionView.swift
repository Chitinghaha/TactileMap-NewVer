//
//  MapInfoListCollectionView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

fileprivate enum Section: CaseIterable {
    case main
}

class MapInfoListCollectionView: UICollectionView {
    
    // Create a Diffable Data Source
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, SingleMapInfoModel> = makeDataSource()
    
    var mapInfoListModel: MapInfoListModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func setupbinding(mapInfoListModel: MapInfoListModel) {
        self.mapInfoListModel = mapInfoListModel
        
        self.register(UINib(nibName: "SingleMapInfoCellView", bundle: nil), forCellWithReuseIdentifier: "SingleMapInfoCellView")
        
        // Load initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleMapInfoModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            self.mapInfoListModel.infos
        )
        self.diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

// MARK: - UITableView DiffableData Source
fileprivate extension MapInfoListCollectionView {
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, SingleMapInfoModel> {
        
        return UICollectionViewDiffableDataSource<Section, SingleMapInfoModel>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, model: SingleMapInfoModel) -> UICollectionViewCell in
            
            let cell: SingleMapInfoCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleMapInfoCellView", for: indexPath) as! SingleMapInfoCellView
            
            cell.mapImageView.image = UIImage(named: model.imageName)
            cell.mapTitleLabel.text = model.title
            cell.subtitleLabel.text = model.description

            if (model.descriptionIconName.count != 0) {
                cell.subtitleIconImageView.isHidden = false
//                cell.subtitleIconImageView.image = UIImage(named: model.descriptionIconName)
            }
            else {
                cell.subtitleIconImageView.isHidden = true
            }

            if (model.favoriteEnabled) {
                cell.favoriteButton.isHidden = false
                cell.favoriteButton.isSelected = model.isFavorite
                cell.favoriteImageView.isHidden = false
            }
            else {
                cell.favoriteButton.isHidden = true
                cell.favoriteImageView.isHidden = true
            }
            
            if (model.isFavorite) {
                cell.favoriteImageView.image = UIImage(systemName: "heart.fill")
            }
            else {
                cell.favoriteImageView.image = UIImage(systemName: "heart")
            }

            return cell
        }
    }
}

extension MapInfoListCollectionView: UICollectionViewDelegate {
    
}
