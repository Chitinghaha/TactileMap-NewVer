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

extension Coordinator where Self: AnyObject {
    
    func showAlert(_ alertStyle: UIAlertController.Style = .alert, title: String = "提醒", message: String, buttons: String..., styles: UIAlertAction.Style?..., handlers: (() -> Void)?...) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)

            // if no button title, provide a default button
            var newButtons = buttons
            if newButtons.isEmpty {
                newButtons.append("確定")
            }
            
            // make handlers have same count as buttons
            var newHandlers = handlers
            while newButtons.count > newHandlers.count {
                newHandlers.append(nil)
            }
            
            // UIAlertController can contain only one .cancle sytle, replace others as .default
            var newStyles = styles
            while newStyles.filter({ $0 == .cancel }).count > 1 {
                if let index = newStyles.lastIndex(where: { $0 == .cancel }) {
                    newStyles[index] = .default
                }
            }
            
            // make styles have same count as buttons
            while newButtons.count > newStyles.count {
                newStyles.append(nil)
            }
            
            // add button to alert
            for (title, (style, handler)) in zip(newButtons, zip(newStyles, newHandlers)) {
                alert.addAction(UIAlertAction(title: title, style: (style ?? .default), handler: { _ in
                    handler?()
                }))
            }
            
            var topViewController = self.navigationController.topViewController
            while let presentedViewController = topViewController?.presentedViewController {
                topViewController = presentedViewController
            }
            topViewController?.present(alert, animated: true)
        }
    }
}
