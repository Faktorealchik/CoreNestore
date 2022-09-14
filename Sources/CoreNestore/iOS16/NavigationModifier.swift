//
//  NavigationModifier.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 14.09.2022.
//

import SwiftUI

public struct NavigationModifier: ViewModifier {
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
    func addNavigation() -> some View {
        modifier(NavigationModifier())
    }
}
