//
//  NavigationModifier.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 14.09.2022.
//

import SwiftUI

public struct NavigationModifier: ViewModifier {
    let color: Color
    
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

public extension View {
    func addNavigation(tint: Color) -> some View {
        modifier(NavigationModifier(color: tint))
    }
}
