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
    
    var mapInfo: Map
    
    var leftSideMenuController: MapDetailSideMenuViewController?
    var leftMenuNavigationController: SideMenuNavigationController!
    let sideMenuManager = SideMenuManager()
    
    init(parentCoordinators: HomepageCoordinator, navigationController: UINavigationController, mapInfo: Map) {
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
        self.hideSideMenu()
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
            self.navigationController.popToViewController(oldVC, animated: true)
        }
        else {
            let vm = TactileMapPageViewModel(mapInfo: self.mapInfo)
            let vc = TactileMapPageViewController(viewModel: vm, coordinator: self)
            self.navigationController.pushViewController(vc, animated: true)
        }
        
        self.hideSideMenu()
    }
    
    func changeTactileMapPage(with mapInfo: Map) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.changeTactileMapPage(with: mapInfo)
            }
            return
        }
        self.mapInfo = mapInfo
        
        let vm = TactileMapPageViewModel(mapInfo: self.mapInfo)
        let newVC = TactileMapPageViewController(viewModel: vm, coordinator: self)
        
        if let oldVC = self.navigationController.viewControllers.first(where: {
            $0.nibName == "TactileMapPageViewController"
        }) {
            self.navigationController.popToViewController(oldVC, animated: false)
        }
        
        var VCs = self.navigationController.viewControllers
        VCs.removeLast()
        VCs.append(newVC)
        self.navigationController.setViewControllers(VCs, animated: true)
        
        self.hideSideMenu()
        
    }
    
    func goToPathTrainingPage(with mapInfo: Map) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.goToPathTrainingPage(with: mapInfo)
            }
            return
        }
        
        let vm = PathTrainingPageViewModel(mapInfo: self.mapInfo)
        let vc = PathTrainingPageViewController(viewModel: vm, coordinator: self)
        
        if let leftSideMenuController = self.leftSideMenuController {
            leftSideMenuController.viewModel.pathTrainingPageViewController = vc
        }
        
        self.navigationController.pushViewController(vc, animated: true)
        self.hideSideMenu()
    }
    
    func setupSideMenu() {
        let vm = MapDetailSideMenuViewModel(coodinator: self,currentMap: self.mapInfo)
        self.leftSideMenuController = MapDetailSideMenuViewController(viewModel: vm)
        
        self.leftMenuNavigationController = SideMenuNavigationController(rootViewController: leftSideMenuController!)
        
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.onTopShadowOpacity = 0.8

        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = 600
        leftMenuNavigationController.settings = settings
        
        self.sideMenuManager.leftMenuNavigationController = leftMenuNavigationController
        self.sideMenuManager.addScreenEdgePanGesturesToPresent(toView: self.navigationController.view, forMenu: .left)

    }

    func hideSideMenu() {
        if let leftMenuNavigationController = self.sideMenuManager.leftMenuNavigationController {
            leftMenuNavigationController.dismiss(animated: false)
        }
    }
    
    func clearSideMenuPath() {
        if let leftSideMenuController = self.leftSideMenuController {
            leftSideMenuController.clearPath()
        }
    }
}
