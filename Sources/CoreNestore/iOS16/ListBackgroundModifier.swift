//
//  ListBackgroundModifier.swift
//  LoveMyself
//
//  Created by Aleksandr Nesterov on 14.09.2022.
//

import SwiftUI

public struct ListBackgroundModifier: ViewModifier {
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

public extension View {
    func addBackgroundModifier() -> some View {
        modifier(ListBackgroundModifier())
    }
}
