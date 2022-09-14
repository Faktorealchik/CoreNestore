//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 14.09.2022.
//

import UIKit

public extension UINavigationBar {
    static func changeAppearance(
        textColor: UIColor,
        tintColor: UIColor,
        backgroundColor: UIColor
    ) {
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor: textColor as Any]
        let image = UIImage(systemName: "chevron.backward")?
            .withTintColor(textColor, renderingMode: .alwaysOriginal)

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundEffect = .none
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: textColor as Any]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor as Any]
        coloredAppearance.backButtonAppearance = backItemAppearance
        coloredAppearance.setBackIndicatorImage(image, transitionMaskImage: image)

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = tintColor

        UITableView.appearance().backgroundColor = .clear
    }
}

