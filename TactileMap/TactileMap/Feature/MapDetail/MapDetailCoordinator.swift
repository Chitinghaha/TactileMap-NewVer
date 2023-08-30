//
//  MapDetailCoordinator.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/30.
//

import Foundation
import UIKit
import SideMenu

class MapDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinators: HomepageCoordinator
    var navigationController: UINavigationController
    
    var mapInfo: SingleMapInfoModel
    
    init(parentCoordinators: HomepageCoordinator, navigationController: UINavigationController, mapInfo: SingleMapInfoModel) {
        self.parentCoordinators = parentCoordinators
        self.navigationController = navigationController
        self.mapInfo = mapInfo
    }
    
    func start() {
        self.goToTactileMapPage(with: self.mapInfo)
    }
    
    func showSideMenu() {
        
    }
    
    func goToHomePage() {
        self.parentCoordinators.backToHomePage()
    }
    
    func goToTactileMapPage(with mapInfo: SingleMapInfoModel) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.goToTactileMapPage(with: mapInfo)
            }
            return
        }
    
        
        let vm = TactileMapPageViewModel(mapInfo: mapInfo)
        let vc = TactileMapPageViewController(viewModel: vm, coordinator: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPathTraningPage() {
        
    }
}
