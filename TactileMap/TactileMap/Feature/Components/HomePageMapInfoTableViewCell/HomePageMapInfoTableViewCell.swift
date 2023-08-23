//
//  HomePageMapInfoTableViewCell.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

class HomePageMapInfoTableViewCell: UITableViewCell {
    var mapInfoListModel: MapInfoListModel

    init(mapInfoListModel: MapInfoListModel) {
        self.mapInfoListModel = mapInfoListModel
        
        super.init(style: .default, reuseIdentifier: "HomePageMapInfoTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let mapInfoListCollectionView = MapInfoListCollectionView(mapInfoListModel: self.mapInfoListModel)
        self.contentView = 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
