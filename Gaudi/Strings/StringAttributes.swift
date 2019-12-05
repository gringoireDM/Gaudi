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
    
    static func foregroundColor(_ color: UIColor) -> StringAttributes {
        StringAttributes(attr: [.foregroundColor: color])
    }
    
    static func foregroundColor(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        foregroundColor(theme.color(forSemanticColor: semanticColor))
    }
    
    static func background(_ color: UIColor) -> StringAttributes {
        StringAttributes(attr: [.backgroundColor: color])
    }
    
    static func background(_ semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        background(theme.color(forSemanticColor: semanticColor))
    }
    
    static func underline(color: UIColor) -> StringAttributes {
        StringAttributes(attr: [.underlineColor: color])
    }
    
    static func underline(semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        underline(theme.color(forSemanticColor: semanticColor))
    }
    
    static func underline(style: NSUnderlineStyle) -> StringAttributes {
        StringAttributes(attr: [.underlineStyle: style.rawValue])
    }
    
    static func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> StringAttributes {
        underline(color: color) + underline(style: style)
    }
    
    static func underline(_ semanticColor: SemanticColor, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
        underline(theme.color(forSemanticColor: semanticColor)) + underline(style: style)
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
    
    static func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> StringAttributes {
        StringAttributes(attr: [NSAttributedString.Key.strikethroughStyle: style.rawValue])
    }
    
    static func paragraphStyle(_ style: NSMutableParagraphStyle) -> StringAttributes {
        StringAttributes(attr: [NSAttributedString.Key.paragraphStyle: style])
    }
}
