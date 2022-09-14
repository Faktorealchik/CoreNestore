//
//  StatusBarModifier.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 14.09.2022.
//

import SwiftUI

/// SHOULD BE CALLED ONLY ONCE PER NAVIGATIONSTACK
public struct StatusBarModifier: ViewModifier {
    let color: ColorScheme?
    
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarColorScheme(color, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        } else {
            content
        }
    }
}

public extension View {
    func statusBar(color: ColorScheme?) -> some View {
        modifier(StatusBarModifier(color: color))
    }
}
