//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 16.09.2022.
//

import UIKit

public var statusBarHeight: CGFloat {
    UIWindow.current?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
}

public extension UIWindow {
    static var safeInsets: UIEdgeInsets {
        return current?.safeAreaInsets ?? .zero
    }
        
    static var isFullScreen: Bool {
        return current?.frame == UIScreen.main.bounds
    }
}

public extension UIWindow {
    static var current: UIWindow? {
        // if scene is not connected will use first normal level key window
        return sceneActiveWindow ?? keyWindow
    }
    
    static var keyWindow: UIWindow? {
        var window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if window == nil || window?.windowLevel != .normal {
            for w in UIApplication.shared.windows {
                if w.windowLevel == .normal {
                    window = w
                }
            }
        }
        return window
    }
    
    static var sceneActiveWindow: UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        return window
    }
}
