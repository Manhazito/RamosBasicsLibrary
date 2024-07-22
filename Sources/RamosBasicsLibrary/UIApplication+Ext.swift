//
//  File.swift
//
//
//  Created by Filipe Ramos on 22/07/2024.
//

import UIKit

public extension UIApplication {
    private var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
    func topViewController() -> UIViewController? {
        let controller = keyWindow?.rootViewController
        return topViewController(controller: controller)
    }
    
    private func topViewController(controller: UIViewController?) -> UIViewController? {
        if let tabController = controller as? UITabBarController {
            return topViewController(controller: tabController.selectedViewController)
        }
        
        if let navController = controller as? UINavigationController {
            return topViewController(controller: navController.visibleViewController)
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
