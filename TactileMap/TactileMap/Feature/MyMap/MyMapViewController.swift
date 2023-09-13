//
//  MyMapViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit
import Combine

class MyMapViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    var mapInfoListCollectionView: MapInfoListCollectionView!
    
    let collectionViewHeight: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initView()
        
        self.setupBinding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    func initView() {
        self.mapInfoListCollectionView = MapInfoListCollectionView.loadFromNib()
        
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

    }
    
    func setupBinding() {
        MapInfosViewModel.shared.$favoriteMaps
            .receive(on: RunLoop.main)
            .sink { _ in
                let maps = MapInfosViewModel.shared.getMyMapList()
                self.mapInfoListCollectionView.setUp(mapsInfo: maps)
                
            }
            .store(in: &cancellable)

    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
