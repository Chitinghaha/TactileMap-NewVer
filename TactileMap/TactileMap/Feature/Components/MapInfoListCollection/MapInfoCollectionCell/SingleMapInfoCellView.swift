//
//  SingleMapInfoCellView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit
import Combine

class SingleMapInfoCellView: UICollectionViewCell {

    @IBOutlet weak var mapImageView: UIImageView! { didSet {
        mapImageView.layer.cornerRadius = 10
    }}
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var mapTitleLabel: UILabel!
    
    @IBOutlet weak var subtitleIconImageView: UIImageView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @Published var isFavorite: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupBinding()
    }
    
    func setupBinding() {
        self.$isFavorite
            .receive(on: RunLoop.main)
            .sink {
                self.favoriteButton.isSelected = $0
                self.favoriteImageView.image = $0 ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
            }
            .store(in: &cancellables)
    }
    
    @IBAction func onClickFavoriteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.isFavorite = sender.isSelected
        MapInfoDataStore.shared.updateFavoriteMaps(mapTitle: self.mapTitleLabel.text ?? "", isFavorite: sender.isSelected)
    }

}
