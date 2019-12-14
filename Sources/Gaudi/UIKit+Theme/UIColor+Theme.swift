//
//  UIColor+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public extension UIColor {
    static func semanticColor(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> UIColor {
        return theme.color(forSemanticColor: semanticColor)
    }

}
