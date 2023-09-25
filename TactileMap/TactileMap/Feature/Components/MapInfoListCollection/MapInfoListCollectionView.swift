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
    
    private var cancellable = Set<AnyCancellable>()

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, Int> = makeDataSource()
    
    var mapsInfo: [Map]!
    var coordinator: MapInfoListCollectionViewCoordinator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func setUp(mapsInfo: [Map]) {
        self.mapsInfo = mapsInfo
        
        self.register(UINib(nibName: "SingleMapInfoCellView", bundle: nil), forCellWithReuseIdentifier: "SingleMapInfoCellView")
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            self.mapsInfo.map { $0.id }
        )
        self.diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

// MARK: - UITableView DiffableData Source
fileprivate extension MapInfoListCollectionView {
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Int> {
        
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, id: Int) -> UICollectionViewCell in
            let model = MapInfoDataStore.shared.allMapsInfo.first(where: { $0.id == id })!
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

extension MapInfoListCollectionView {
    func setupBinding() {
        MapInfoDataStore.shared.didUpdateMap
            .receive(on: RunLoop.main)
            .sink{ map in
                var snapshot = self.diffableDataSource.snapshot()
                if (snapshot.itemIdentifiers.contains(map.id)) {
                    snapshot.reloadItems([map.id])
                    self.diffableDataSource.apply(snapshot, animatingDifferences: true)
                }
            }
            .store(in: &cancellable)

    }
}
