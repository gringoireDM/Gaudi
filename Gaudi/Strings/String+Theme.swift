//
//  String+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension StringProtocol {
    func foreground(color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .foreground(color: color) }
    }
    
    func foreground(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .foreground(semanticColor: semanticColor, usingTheme: theme) }
    }
    
    func background(color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .background(color: color) }
    }
    
    func background(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .background(semanticColor: semanticColor, usingTheme: theme) }
    }
    
    func underline(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .underline(color: color, andStyle: style) }
    }
    
    func underline(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .underline(semanticColor: semanticColor, andStyle: style, usingTheme: theme) }
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
    
    func strikethrough(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .strikethrough(color: color, andStyle: style) }
    }
    
    func strikethrough(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .strikethrough(semanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func paragraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        NSAttributedString(string: String(self)) { .paragraphStyle(style) }
    }
    
    var attributed: NSAttributedString {
        NSAttributedString(string: String(self))
    }
}
