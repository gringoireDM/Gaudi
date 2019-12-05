//
//  UIFont+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public extension UIFont {
    static func font(forStyle style: FontStyle, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> UIFont {
        return theme.font(forStyle: style)
    }
}
