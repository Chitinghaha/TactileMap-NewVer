//
//  HomepageContainerViewController.swift
//  TactileMap
//
//  Created by 陳邦亢 on 2023/8/23.
//

import UIKit

class HomepageContainerViewController: UITabBarController {

    var coordinator: HomepageContainerCoordinator
    var homepageCoordinator: HomepageCoordinator
    
    // MARK: Life Cycle
    init(coordinator: HomepageContainerCoordinator, homepageCoordinator: HomepageCoordinator) {
        self.coordinator = coordinator
        self.homepageCoordinator = homepageCoordinator
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homepageVM = HomepageViewModel()
        let homepageVC = HomepageViewController(viewModel: homepageVM, coordinator: self.homepageCoordinator)
        homepageVC.tabBarItem = UITabBarItem(title: "首頁", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//        let myMapVC = MyMapViewController(nibName: "MyMapViewController", bundle: nil)
//        myMapVC.tabBarItem = UITabBarItem(title: "我的地圖", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
//
//        let societyVC = SocietyViewController(nibName: "SocietyViewController", bundle: nil)
//        societyVC.tabBarItem = UITabBarItem(title: "社群", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
//
//        let personalVC = PersonalViewController(nibName: "PersonalViewController", bundle: nil)
//        personalVC.tabBarItem = UITabBarItem(title: "個人專區", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
//        self.viewControllers = [homepageVC, myMapVC, societyVC, personalVC]
        self.viewControllers = [homepageVC]
        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().tintColor = UIColor(red: 0.73, green: 0.74, blue: 0.91, alpha: 1.00)
//        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.78, green: 0.81, blue: 0.82, alpha: 1.00)
        // Do any additional setup after loading the view.
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
