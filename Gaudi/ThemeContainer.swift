//
//  ThemeManager.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public protocol WindowsContainer {
    var windows: [UIWindow] { get }
}

extension UIApplication: WindowsContainer { }

public class ThemeContainer {
    public static var windowsContainer: WindowsContainer = UIApplication.shared
    public static var currentTheme: ThemeProtocol! {
        didSet {
            if let old = oldValue {
                old.appearanceRules.revert()
            }
            
            windowsContainer.windows.forEach { window in
                window.applyTheme(currentTheme)
            }
        }
    }
}
