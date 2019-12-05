//
//  ThemeManager.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public class ThemeContainer {
    public static var currentTheme: ThemeProtocol! {
        didSet {
            if let old = oldValue {
                old.appearanceRules.revert()
            }
            
            UIApplication.shared.windows.forEach { window in
                window.applyTheme(currentTheme)
            }
        }
    }
}
