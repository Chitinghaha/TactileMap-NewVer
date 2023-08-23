//
//  Coordinator.swift
//  HiIndoorAirQuality
//
//  Created by 陳邦亢 on 2023/8/7.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
