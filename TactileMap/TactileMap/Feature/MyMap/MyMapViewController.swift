//
//  MyMapViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit
import Combine

class MyMapViewController: UIViewController {
    
    var coordinator: MapInfoListCollectionViewCoordinator

    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    var mapInfoListCollectionView: MapInfoListCollectionView!
    
    let collectionViewHeight: CGFloat = 400
    
    init(coordinator: MapInfoListCollectionViewCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    func initView() {
        self.mapInfoListCollectionView = MapInfoListCollectionView.loadFromNib()
        self.mapInfoListCollectionView.coordinator = self.coordinator
        self.mapInfoListCollectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: (self.mapInfoListCollectionView.frame.size.width - 100) / 3, height: self.collectionViewHeight)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 50)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 50)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.mapInfoListCollectionView.collectionViewLayout = layout
        self.mapInfoListCollectionView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        
        self.contentStackView.addArrangedSubview(self.mapInfoListCollectionView)

        let maps = MapInfoDataStore.shared.getFavoriteMaps()
        self.mapInfoListCollectionView.setUp(mapsInfo: maps)

    }
    
    func setupBinding() {
        MapInfoDataStore.shared.didUpdateMap
            .receive(on: RunLoop.main)
            .sink{ map in
                let maps = MapInfoDataStore.shared.getFavoriteMaps()
                self.mapInfoListCollectionView.setUp(mapsInfo: maps)
            }
            .store(in: &cancellable)

    }

}
