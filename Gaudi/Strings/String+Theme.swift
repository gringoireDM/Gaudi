//
//  String+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension StringProtocol {
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .foregroundColor(color) }
    }
    
    func foregroundColor(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .foregroundColor(semanticColor, usingTheme: theme) }
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .background(color) }
    }
    
    func background(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .background(semanticColor, usingTheme: theme) }
    }
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .underline(color, style: style) }
    }
    
    func underline(_ semanticColor: SemanticColor, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .underline(semanticColor, style: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .font(font, withKern: kern) }
    }
    
    func font(forStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .font(forStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .shadow(shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .baselineOffset(offset) }
    }
    
    func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .strikethroughStyle(style) }
    }
    
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .paragraphStyle(style) }
    }
    
    var attributed: NSAttributedString {
        NSAttributedString(string: String(self))
    }
}
