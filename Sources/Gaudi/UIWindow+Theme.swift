//
//  UIWindow+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public extension UIWindow {
    func applyTheme(_ theme: ThemeProtocol) {
        theme.appearanceRules.apply()
        for view in subviews {
            view.removeFromSuperview()
            addSubview(view)
        }
        
        guard let root = rootViewController else { return }
        UIWindow.traverseViewControllerStackApplyingTheme(from: root)
    }
    
    static func traverseViewControllerStackApplyingTheme(from root: UIViewController) {
        // Standard BFS traversal.
        var queue = Set([root])
        var visited = Set<UIViewController>()
        
        while let controller = queue.first {
            queue.removeFirst()
            visited.insert(controller)
            (controller as? Themed)?.applyTheme()
            controller.children.forEach { queue.insert($0) }
            if let presented = controller.presentedViewController,
                !visited.contains(presented) {
                queue.insert(presented)
            }
        }
    }
}

@objc public extension UIWindow {
    func applyDefaultTheme(overrideLocal: Bool) {
        applyTheme(ThemeContainer.currentTheme)
    }
}

open class ThemedWindow: UIWindow {
    public var lightTheme: ThemeProtocol {
        didSet {
            if #available(iOS 13.0, *) {
                switch UITraitCollection.current.userInterfaceStyle {
                case .light, .unspecified: applyCurrentTheme()
                case .dark: break
                @unknown default: applyCurrentTheme()
                }
            } else {
                applyCurrentTheme()
            }
        }
    }
    
    public var darkTheme: ThemeProtocol {
        didSet {
            guard #available(iOS 13.0, *),
                case .dark = UITraitCollection.current.userInterfaceStyle else { return }
            applyCurrentTheme()
        }
    }
    
    public var currentTheme: ThemeProtocol {
        if #available(iOS 13.0, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .light, .unspecified: return lightTheme
            case .dark: return darkTheme
            @unknown default: return lightTheme
            }
        } else {
            return lightTheme
        }
    }
    
    public required init(lightTheme: ThemeProtocol, darkTheme: ThemeProtocol) {
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
        super.init(frame: .zero)
        
        applyCurrentTheme()
    }
    
    @available(iOS 13.0, *)
    public required init(lightTheme: ThemeProtocol, darkTheme: ThemeProtocol, windowScene: UIWindowScene) {
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
        super.init(windowScene: windowScene)
        
        applyCurrentTheme()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard #available(iOS 13.0, *), previousTraitCollection != UITraitCollection.current else { return }
        applyCurrentTheme()
    }
    
    func applyCurrentTheme() {
        ThemeContainer.currentTheme = currentTheme
    }
}
