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
        self.showHomePageContainerVC()
    }
    
    func showHomePageContainerVC() {
        if let oldHomepageContainerVC = self.navigationController.viewControllers.first(where: {
            $0.nibName == "HomepageContainerViewController"
        }) {
            self.navigationController.popToViewController(oldHomepageContainerVC, animated: false)
        }
        else {
            let homepageContainerVC = HomepageContainerViewController(coordinator: self, homepageCoordinator: self)
            
            self.navigationController.pushViewController(homepageContainerVC, animated: false)
        }
    }
    
    func goToMapDetail(with mapInfo: Map) {
        let mapDetailCoordinator = MapDetailCoordinator(parentCoordinators: self, navigationController: self.navigationController, mapInfo: mapInfo)
        self.childCoordinators.append(mapDetailCoordinator)
        
        mapDetailCoordinator.start()
    }

    func backToHomePage() {
        self.childCoordinators.removeAll()
        
        self.showHomePageContainerVC()
    }
}
