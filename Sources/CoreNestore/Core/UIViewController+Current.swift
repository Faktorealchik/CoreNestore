//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 16.09.2022.
//

import UIKit

public extension UIViewController {

    /// Retrieve the view controller currently on-screen
    ///
    /// Based off code here:
    ///  http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
    static var current: UIViewController? {
        if let controller = UIWindow.current?.rootViewController {
            return findCurrent(controller)
        }
        return nil
    }

    private static func findCurrent(_ controller: UIViewController) -> UIViewController {
        if let controller = controller.presentedViewController {
            return findCurrent(controller)
        } else if let controller = controller as? UISplitViewController,
                    let lastViewController = controller.viewControllers.first,
                    !controller.viewControllers.isEmpty {
            return findCurrent(lastViewController)
        } else if let controller = controller as? UINavigationController,
                    let topViewController = controller.topViewController,
                    !controller.viewControllers.isEmpty {
            return findCurrent(topViewController)
        } else if let controller = controller as? UITabBarController,
                    let selectedViewController = controller.selectedViewController,
                  controller.viewControllers?.isEmpty == false {
            return findCurrent(selectedViewController)
        } else {
            return controller
        }
    }
}

public extension UIViewController {
    var isDarkMode: Bool {
        return traitCollection.userInterfaceStyle == .dark
    }
}

public extension UIViewController {
    // SwifterSwift: Check if ViewController is onscreen and not hidden.
    // from https://github.com/SwifterSwift/SwifterSwift
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }

    func dismiss() {
        if let navigationController = navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    func dismissToRootViewController(animated: Bool) {
        var vc = self
        while let current = vc.presentingViewController {
            vc = current
        }
        vc.dismiss(animated: animated, completion: nil)
        vc.navigationController?.popToRootViewController(animated: animated)
    }
}

public extension UIViewController {
    func load(_ viewController: UIViewController, on view: UIView) {
        // `willMoveToParentViewController:` is called automatically when adding
        
        addChild(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(viewController.view)
        
        viewController.didMove(toParent: self)
    }
    
    func unload(_ viewController: UIViewController) {
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        // `didMoveToParentViewController:` is called automatically when removing
    }
}
