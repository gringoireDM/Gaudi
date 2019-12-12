//
//  StringAttributes.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public struct StringAttributes {
    public let attributes: [NSAttributedString.Key: Any]
    
    public init(attr: [NSAttributedString.Key: Any]) {
        self.attributes = attr
    }
    
    public static let empty = StringAttributes(attr: [:])
    
    public static func + (lhs: StringAttributes, rhs: StringAttributes) -> StringAttributes {
        StringAttributes(attr: lhs.attributes.merging(rhs.attributes) { _, new in new })
    }
}

public extension StringAttributes {
    
    static func foreground(color: UIColor) -> StringAttributes {
        StringAttributes(attr: [.foregroundColor: color])
    }
    
    static func foreground(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        foreground(color: theme.color(forSemanticColor: semanticColor))
    }
    
    static func background(color: UIColor) -> StringAttributes {
        StringAttributes(attr: [.backgroundColor: color])
    }
    
    static func background(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        background(color: theme.color(forSemanticColor: semanticColor))
    }
        
    static func underline(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> StringAttributes {
        StringAttributes(attr: [
            .underlineStyle: style.rawValue,
            .underlineColor: color
        ])
    }
    
    static func underline(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        StringAttributes(attr: [
            .underlineStyle: style.rawValue,
            .underlineColor: theme.color(forSemanticColor: semanticColor)
        ])
    }
    
    static func font(_ font: UIFont, withKern kern: CGFloat = 0) -> StringAttributes {
        StringAttributes(attr: [.font: font, .kern: kern])
    }
    
    static func font(forStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        font(theme.font(forStyle: style), withKern: kerned ? theme.kern(forStyle: style) : 0)
    }
    
    static func shadow(_ shadow: NSShadow) -> StringAttributes {
        StringAttributes(attr: [.shadow: shadow])
    }
    
    static func baselineOffset(_ offset: CGFloat) -> StringAttributes {
        StringAttributes(attr: [.baselineOffset: offset])
    }
    
    static func strikethrough(color: UIColor, andStyle style: NSUnderlineStyle = .single) -> StringAttributes {
        StringAttributes(attr: [.strikethroughStyle: style.rawValue, .strikethroughColor: color])
    }
    
    static func strikethrough(semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        StringAttributes(attr: [.strikethroughStyle: style.rawValue, .strikethroughColor: theme.color(forSemanticColor: semanticColor)])
    }
    
    static func paragraphStyle(_ style: NSParagraphStyle) -> StringAttributes {
        StringAttributes(attr: [.paragraphStyle: style])
    }
}
