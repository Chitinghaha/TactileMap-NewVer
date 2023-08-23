//
//  ViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/21.
//

import UIKit

class AppMainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    private let window: UIWindow

    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        
        
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()        
    }
    
    func start() {
        self.gotoHomePage()
    }
    
    func gotoHomePage() {
        let homepageContainerVC = HomepageContainerViewController(nibName: "HomepageContainerViewController", bundle: nil)
        self.navigationController.pushViewController(homepageContainerVC, animated: false)
        
    }

}

