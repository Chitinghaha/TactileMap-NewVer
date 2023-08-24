//
//  MyMapViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

class MyMapViewController: UIViewController {
    
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    var mapInfoListCollectionView: MapInfoListCollectionView!
    
    //    var mapInfoListModel: MapInfoListModel?
    let collectionViewHeight: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let model = MapInfoListModel(title: "學餐", infos: [
            SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle1", description: "testDescription1", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle2", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap3", title: "testTitle3", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle4", description: "testDescription1", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle5", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap3", title: "testTitle6", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap1", title: "testTitle7", description: "testDescription1", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap2", title: "testTitle8", description: "testDescription2", descriptionIconName: "", favoriteEnabled: true, isFavorite: true),
            SingleMapInfoModel(imageName: "tmpMap3", title: "testTitle9", description: "testDescription3", descriptionIconName: "", favoriteEnabled: true, isFavorite: true)
        ]
        )
        
        self.mapInfoListCollectionView = MapInfoListCollectionView.loadFromNib()
        //        self.view.addSubview(self.mapInfoListCollectionView)
        
        self.mapInfoListCollectionView.setupbinding(mapInfoListModel: model)
        
        self.mapInfoListCollectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: (self.mapInfoListCollectionView.frame.size.width - 100) / 3, height: self.collectionViewHeight)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 50)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 50)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.mapInfoListCollectionView.collectionViewLayout = layout
        self.mapInfoListCollectionView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        let estimatedHeight = CGFloat(model.infos.count / 3 + 1) * (self.collectionViewHeight + 50)
        
        self.mapInfoListCollectionView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
        
        self.contentStackView.addArrangedSubview(self.mapInfoListCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillLayoutSubviews() {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
