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
    
    @IBOutlet var collectionView: UICollectionView!
    // Create a Diffable Data Source
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Section, SingleMapInfoModel> = makeDataSource()
    
    var mapInfoListModel: MapInfoListModel
    
    init(mapInfoListModel: MapInfoListModel) {
        self.mapInfoListModel = mapInfoListModel
        
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        // Load initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleMapInfoModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(
            self.mapInfoListModel.infos ??
            [SingleMapInfoModel(imageName: "soup2", title: "小吃部test", description: "2023083", descriptionIconName: "clock", favoriteEnabled: true, isFavorite: true)]
        )
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViewFromNib()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

// MARK: - UITableView DiffableData Source
fileprivate extension MapInfoListCollectionView {
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, SingleMapInfoModel> {
        
        return UICollectionViewDiffableDataSource<Section, SingleMapInfoModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, model: SingleMapInfoModel) -> SingleMapInfoCellView? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SingleMapInfoCellView.self), for: indexPath) as! SingleMapInfoCellView
            
            cell.mapImageView.image = UIImage(named: model.imageName)
            cell.mapTitleLabel.text = model.title
            cell.subtitleLabel.text = model.description
            
            if (model.descriptionIconName.count != 0) {
                cell.subtitleIconImageView.isHidden = false
                cell.subtitleIconImageView.image = UIImage(named: model.descriptionIconName)
            }
            else {
                cell.subtitleIconImageView.isHidden = true
            }
            
            if (model.favoriteEnabled) {
                cell.favoriteButton.isHidden = false
                cell.favoriteButton.isSelected = model.isFavorite
            }
            else {
                cell.favoriteButton.isHidden = true
            }
            
            return cell
        }
    }
}
