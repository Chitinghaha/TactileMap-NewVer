//
//  HomepageContainerCoordinator.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/29.
//

import UIKit

class HomepageContainerCoordinator: Coordinator, MapInfoListCollectionViewCoordinator, HomepageCoordinator {
    
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        let homepageContainerVC = HomepageContainerViewController(coordinator: self, homepageCoordinator: self)
        
        self.navigationController.pushViewController(homepageContainerVC, animated: false)
    }
    
    func goToMapDetail(with mapInfo: SingleMapInfoModel) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.goToMapDetail(with: mapInfo)
            }
            return
        }
        
        let vm = TactileMapPageViewModel(mapInfo: mapInfo)
        let vc = TactileMapPageViewController(nibName: "TactileMapPageViewController", bundle: nil)
        
        vc.viewModel = vm
        self.navigationController.pushViewController(vc, animated: true)
        
    }

    
}
