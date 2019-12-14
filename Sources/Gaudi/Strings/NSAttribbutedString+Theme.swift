//
//  NSAttribbutedString+Theme.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    func apply(inRange range: NSRange, @AttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.addAttributes(attributes().attributes, range: range)
        return mutable
    }

    func apply(@AttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        apply(inRange: NSMakeRange(0, (string as NSString).length), attributes: attributes)
    }
    
    func foreground(color: UIColor) -> NSAttributedString {
        apply { foregroundAttribute(withColor: color) }
    }
    
    func foreground(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { foregroundAttribute(withSemanticColor: semanticColor, usingTheme: theme) }
    }
    
    func background(color: UIColor) -> NSAttributedString {
        apply { backgroundAttribute(withColor: color) }
    }
    
    func background(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { backgroundAttribute(withSemanticColor: semanticColor, usingTheme: theme) }
    }
    
    func underline(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { underlineAttribute(withColor: color, andStyle: style) }
    }
    
    func underline(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { underlineAttribute(withSemanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        apply { fontAttribute(withFont: font, andKern: kern) }
    }
    
    func font(forStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { fontAttribute(withStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        apply { shadowAttribute(withShadow: shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        apply { baselineOffsetAttribute(withOffset: offset) }
    }
    
    func strikethrough(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { strikethroughAttribute(withColor: color, andStyle: style) }
    }
    
    func strikethrough(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> NSAttributedString {
        apply { strikethroughAttribute(withSemanticColor: semanticColor, andStyle: style, usingTheme: theme) }
    }
    
    func paragraphStyle(_ style: NSParagraphStyle) -> NSAttributedString {
        apply { paragraphStyleAttribute(withStyle: style) }
    }
}
