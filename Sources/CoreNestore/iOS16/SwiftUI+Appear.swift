//
//  File.swift
//  
//
//  Created by Aleksandr Nesterov on 16.09.2022.
//

import SwiftUI

public struct AppearHandler: UIViewControllerRepresentable {
    public func makeCoordinator() -> AppearHandler.Coordinator {
        Coordinator(
            onWillAppear: onWillAppear,
            onWillDisappear: onWillDisappear,
            onDidAppear: onDidAppear,
            onDidDisappear: onDidDisappear)
    }

    let onWillAppear: (() -> Void)?
    let onWillDisappear: (() -> Void)?
    let onDidAppear: (() -> Void)?
    let onDidDisappear: (() -> Void)?

    public func makeUIViewController(context: UIViewControllerRepresentableContext<AppearHandler>) -> UIViewController {
        context.coordinator
    }

    public func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<AppearHandler>
    ) {
    }

    public typealias UIViewControllerType = UIViewController

    public class Coordinator: UIViewController {
        let onWillAppear: (() -> Void)?
        let onWillDisappear: (() -> Void)?
        let onDidAppear: (() -> Void)?
        let onDidDisappear: (() -> Void)?

        init(
            onWillAppear: (() -> Void)?,
            onWillDisappear: (() -> Void)?,
            onDidAppear: (() -> Void)?,
            onDidDisappear: (() -> Void)?
        ) {
            self.onWillDisappear = onWillDisappear
            self.onWillAppear = onWillAppear
            self.onDidAppear = onDidAppear
            self.onDidDisappear = onDidDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear?()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear?()
        }
        
        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear?()
        }
        
        public override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDidDisappear?()
        }
    }
}

public struct AppearHandlerModifier: ViewModifier {
    let willAppear: (() -> Void)?
    let willDisappear: (() -> Void)?
    let onDidAppear: (() -> Void)?
    let onDidDisappear: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .background(AppearHandler(
                onWillAppear: willAppear,
                onWillDisappear: willDisappear,
                onDidAppear: onDidAppear,
                onDidDisappear: onDidDisappear))
    }
}

public extension View {
    func onUikitActions(
        onAppear: (() -> Void)? = nil,
        onDisappear: (() -> Void)? = nil,
        onDidAppear: (() -> Void)? = nil,
        onDidDisappear: (() -> Void)? = nil
    ) -> some View {
        Group {
            if #available(iOS 16.0, *) {
                self.onAppear {
                    onAppear?()
                    onDidAppear?()
                }.onDisappear {
                    onDisappear?()
                    onDidDisappear?()
                }
            } else {
                self.modifier(AppearHandlerModifier(
                    willAppear: onAppear,
                    willDisappear: onDisappear,
                    onDidAppear: onDidAppear,
                    onDidDisappear: onDidDisappear))
            }
        }
    }
    
    func onElementAppear(_ onAppear: (() -> Void)? = nil) -> some View {
        self.onAppear { onAppear?() }
    }
}
