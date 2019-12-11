//
//  NSAttribbutedString+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public extension NSAttributedString {
    func apply(inRange range: NSRange, @AttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: string, attributes: self.attributes(at: 0, effectiveRange: nil))
        mutable.addAttributes(attributes().attributes, range: range)
        return mutable
    }

    func apply(@AttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        apply(inRange: NSMakeRange(0, (string as NSString).length), attributes: attributes)
    }
    
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        apply { .foregroundColor(color) }
    }
    
    func foregroundColor(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .foregroundColor(semanticColor, usingTheme: theme) }
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        apply { .background(color) }
    }
    
    func background(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .background(semanticColor, usingTheme: theme) }
    }
    
    func underline(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { .underline(color: color, andStyle: style) }
    }
    
    func underline(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .underline(semanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        apply { .font(font, withKern: kern) }
    }
    
    func font(forStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .font(forStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        apply { .shadow(shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        apply { .baselineOffset(offset) }
    }
    
    func strikethrough(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { .strikethrough(color: color, andStyle: style) }
    }
    
    func strikethrough(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .strikethrough(semanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func paragraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        apply { .paragraphStyle(style) }
    }
}
