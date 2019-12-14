//
//  StringAttributes.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

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

public func foregroundAttribute(withColor color: UIColor) -> StringAttributes {
    StringAttributes(attr: [.foregroundColor: color])
}

public func foregroundAttribute(withSemanticColor semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
    foregroundAttribute(withColor: theme.color(forSemanticColor: semanticColor))
}

public func backgroundAttribute(withColor color: UIColor) -> StringAttributes {
    StringAttributes(attr: [.backgroundColor: color])
}

public func backgroundAttribute(withSemanticColor semanticColor: SemanticColor, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
    backgroundAttribute(withColor: theme.color(forSemanticColor: semanticColor))
}

public func underlineAttribute(withColor color: UIColor, andStyle style: NSUnderlineStyle = .single) -> StringAttributes {
    StringAttributes(attr: [
        .underlineStyle: style.rawValue,
        .underlineColor: color
    ])
}

public func underlineAttribute(withSemanticColor semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
    StringAttributes(attr: [
        .underlineStyle: style.rawValue,
        .underlineColor: theme.color(forSemanticColor: semanticColor)
    ])
}

public func fontAttribute(withFont font: UIFont, andKern kern: CGFloat = 0) -> StringAttributes {
    StringAttributes(attr: [.font: font, .kern: kern])
}

public func fontAttribute(withStyle style: FontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
    fontAttribute(withFont: theme.font(forStyle: style), andKern: kerned ? theme.kern(forStyle: style) : 0)
}

public func shadowAttribute(withShadow shadow: NSShadow) -> StringAttributes {
    StringAttributes(attr: [.shadow: shadow])
}

public func baselineOffsetAttribute(withOffset offset: CGFloat) -> StringAttributes {
    StringAttributes(attr: [.baselineOffset: offset])
}

public func strikethroughAttribute(withColor color: UIColor, andStyle style: NSUnderlineStyle = .single) -> StringAttributes {
    StringAttributes(attr: [.strikethroughStyle: style.rawValue, .strikethroughColor: color])
}

public func strikethroughAttribute(withSemanticColor semanticColor: SemanticColor, andStyle style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.currentTheme) -> StringAttributes {
    StringAttributes(attr: [.strikethroughStyle: style.rawValue, .strikethroughColor: theme.color(forSemanticColor: semanticColor)])
}

public func paragraphStyleAttribute(withStyle style: NSParagraphStyle) -> StringAttributes {
    StringAttributes(attr: [.paragraphStyle: style])
}

