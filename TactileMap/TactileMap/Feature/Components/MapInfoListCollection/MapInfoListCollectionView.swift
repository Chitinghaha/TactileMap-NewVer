//
//  MapInfoListCollectionView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit
import Combine

fileprivate enum Section: CaseIterable {
    case main
}

class MapInfoListCollectionView: UICollectionView {
    
    private var cancellables = Set<AnyCancellable>()
    
    // Create a Diffable Data Source
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, SingleMapInfoModel> = makeDataSource()
    
    var mapsInfo: [SingleMapInfoModel]!
    var coordinator: MapInfoListCollectionViewCoordinator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func setUp(mapsInfo: [SingleMapInfoModel]) {
        self.mapsInfo = mapsInfo
        
        self.register(UINib(nibName: "SingleMapInfoCellView", bundle: nil), forCellWithReuseIdentifier: "SingleMapInfoCellView")
        
        // Load initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleMapInfoModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            self.mapsInfo
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
            
            cell.mapImageView.image = UIImage(named: model.imageName) ?? UIImage(named: "defaultMapThumbnail")
            cell.mapTitleLabel.text = model.title
            cell.subtitleLabel.text = model.description

            if (model.descriptionIconName.count != 0) {
                cell.subtitleIconImageView.isHidden = false
                cell.subtitleIconImageView.image = UIImage(systemName: model.descriptionIconName)
            }
            else {
                cell.subtitleIconImageView.isHidden = true
            }

            cell.isFavorite = model.isFavorite ?? false
       
            return cell
        }
    }
}

extension MapInfoListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.coordinator.goToMapDetail(with: self.mapsInfo[indexPath.row])
    }
}
