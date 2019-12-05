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
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { .underline(color, style: style) }
    }
    
    func underline(_ semanticColor: SemanticColor, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { .underline(semanticColor, style: style, usingTheme: theme) }
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
    
    func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { .strikethroughStyle(style) }
    }
    
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
        apply { .paragraphStyle(style) }
    }
}
