//
//  ViewControllerX.swift
//  KoingX
//
//  Created by KoingDev on 4/5/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    // MARK: - Top most view controller
    
    public static var topMostViewController: UIViewController {
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController ?? UIViewController()
    }
    
    fileprivate var topMostViewController: UIViewController {
        if let vc = presentedViewController {
            return vc.topMostViewController
        }
        if let navigation = self as? UINavigationController {
            if let visible = navigation.visibleViewController {
                return visible.topMostViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.topMostViewController
            }
            return tab.topMostViewController
        }
        return self
    }
        
}
