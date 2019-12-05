//
//  UILabel+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public extension UILabel {
    func applyLabelStyle(_ style: FontStyle, semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) {
        textColor = theme.color(forSemanticColor: semanticColor)
        font = theme.font(forStyle: style)
    }
}

public extension Array where Element: UILabel {
    func applyLabelsStyle(_ style: FontStyle, semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) {
        forEach {
            $0.applyLabelStyle(style, semanticColor: semanticColor, usingTheme: theme)
        }
    }
}
