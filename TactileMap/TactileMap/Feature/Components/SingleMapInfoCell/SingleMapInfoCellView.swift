//
//  SingleMapInfoCellView.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

class SingleMapInfoCellView: UICollectionViewCell {

    @IBOutlet weak var mapImageView: UIImageView! { didSet {
        mapImageView.layer.cornerRadius = 10
    }}
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var mapTitleLabel: UILabel!
    
    @IBOutlet weak var subtitleIconImageView: UIImageView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
