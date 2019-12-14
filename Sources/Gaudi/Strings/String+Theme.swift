//
//  String+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit

public extension StringProtocol {
    func foreground(color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.foregroundAttribute(withColor: color) }
    }
    
    func foreground(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.foregroundAttribute(withSemanticColor: semanticColor, usingTheme: theme) }
    }
    
    func background(color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.backgroundAttribute(withColor: color) }
    }
    
    func background(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.backgroundAttribute(withSemanticColor: semanticColor, usingTheme: theme) }
    }
    
    func underline(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.underlineAttribute(withColor: color, andStyle: style) }
    }
    
    func underline(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.underlineAttribute(withSemanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.fontAttribute(withFont: font, andKern: kern) }
    }
    
    func font(forStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.fontAttribute(withStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.shadowAttribute(withShadow: shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.baselineOffsetAttribute(withOffset: offset) }
    }
    
    func strikethrough(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.strikethroughAttribute(withColor: color, andStyle: style) }
    }
    
    func strikethrough(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.strikethroughAttribute(withSemanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func paragraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        NSAttributedString(string: String(self)) { Gaudi.paragraphStyleAttribute(withStyle: style) }
    }
    
    var attributed: NSAttributedString {
        NSAttributedString(string: String(self))
    }
}
