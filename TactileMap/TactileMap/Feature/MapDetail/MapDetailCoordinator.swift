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
    
    var leftMenuNavigationController: SideMenuNavigationController!
    let sideMenuManager = SideMenuManager()
    
    init(parentCoordinators: HomepageCoordinator, navigationController: UINavigationController, mapInfo: SingleMapInfoModel) {
        self.parentCoordinators = parentCoordinators
        self.navigationController = navigationController
        self.mapInfo = mapInfo

        self.setupSideMenu()
    }
    
    func start() {
        self.goToTactileMapPage()
    }
    
    func goToHomePage() {
        self.parentCoordinators.backToHomePage()
        if let leftMenuNavigationController = self.sideMenuManager.leftMenuNavigationController {
            leftMenuNavigationController.dismiss(animated: false)
        }
    }
    
    func goToTactileMapPage() {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.goToTactileMapPage()
            }
            return
        }
        if let oldVC = self.navigationController.viewControllers.first(where: {
            $0.nibName == "TactileMapPageViewController"
        }) {
            self.navigationController.popToViewController(oldVC, animated: false)
        }
        else {
            let vm = TactileMapPageViewModel(mapInfo: self.mapInfo)
            let vc = TactileMapPageViewController(viewModel: vm, coordinator: self)
            self.navigationController.pushViewController(vc, animated: true)
        }
        if let leftMenuNavigationController = self.sideMenuManager.leftMenuNavigationController {
            leftMenuNavigationController.dismiss(animated: false)
        }
    }
    
    func goToPathTrainingPage(with mapInfo: SingleMapInfoModel) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.goToPathTrainingPage(with: mapInfo)
            }
            return
        }
        
        let vm = PathTrainingPageViewModel(mapInfo: self.mapInfo)
        let vc = PathTrainingPageViewController(viewModel: vm, coordinator: self)
        
        self.navigationController.pushViewController(vc, animated: true)
        if let leftMenuNavigationController = self.sideMenuManager.leftMenuNavigationController {
            leftMenuNavigationController.dismiss(animated: false)
        }
    }
    
    func setupSideMenu() {
        let vm = MapDetailSideMenuViewModel(coodinator: self,currentMap: self.mapInfo)
        let leftSideMenuController = MapDetailSideMenuViewController(viewModel: vm)
        
        self.leftMenuNavigationController = SideMenuNavigationController(rootViewController: leftSideMenuController)
        
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.onTopShadowOpacity = 0.8

        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = 600
        leftMenuNavigationController.settings = settings
        
        self.sideMenuManager.leftMenuNavigationController = leftMenuNavigationController
        self.sideMenuManager.addScreenEdgePanGesturesToPresent(toView: self.navigationController.view, forMenu: .left)

    }

    
}
