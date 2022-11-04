//
//  DeviceShakeViewModifier.swift
//  
//
//  Created by Aleksandr Nesterov on 04.11.2022.
//

import Foundation
import SwiftUI
import UIKit

public struct DeviceShakeViewModifier: ViewModifier {
    public let action: () -> Void

    public func body(content: Content) -> some View {
        content
            .onElementAppear {
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        modifier(DeviceShakeViewModifier(action: action))
    }
}

public extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

public extension UIWindow {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}
