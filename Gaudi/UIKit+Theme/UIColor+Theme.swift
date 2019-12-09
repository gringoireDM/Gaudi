//
//  UIColor+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public extension UIColor {
    static func semanticColor(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> UIColor {
        return theme.color(forSemanticColor: semanticColor)
    }
    
    @available(iOS 13.0, *)
    convenience init(lightColor: UIColor, darkColor: UIColor) {
        self.init { (traits) -> UIColor in
            switch traits.userInterfaceStyle {
            case .light: return lightColor
            case .dark: return darkColor
            case .unspecified: return lightColor
            @unknown default: return lightColor
            }
        }
    }
}
