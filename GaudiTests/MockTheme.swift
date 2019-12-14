//
//  MockTheme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 7/23/19.
//  Copyright © 2019 Moda Operandi. All rights reserved.
//

import Foundation
import Gaudi

extension SemanticColor {
    var color: UIColor {
        switch self {
        case .label(let labelColor):
            switch labelColor {
            case .primary: return .black
            case .secondary: return .darkGray
            case .tertiary: return .gray
            case .quaternary: return .lightGray
            case .placeholder: return .lightGray
            case .link: return .blue
            case let .custom(color): return color
            }
        case .fill(let fillColor):
            switch fillColor {
            case .primary: return .blue
            case .secondary: return .darkGray
            case .tertiary: return .green
            case .quaternary: return .red
            case .accent: return .cyan
            case let .custom(color): return color
            }
        case .background(let backgroundColor):
            switch backgroundColor {
            case .primary: return .white
            case .secondary: return .gray
            case .tertiary: return .lightGray
            case let .custom(color): return color
            }
        case .groupedBackground(let groupedBackgroundColor):
            switch groupedBackgroundColor {
            case .primary: return .white
            case .secondary: return .gray
            case .tertiary: return .lightGray
            case let .custom(color): return color
            }
        case .separator(let separatorColor):
            switch separatorColor {
            case .semiTransparent: return UIColor.darkGray.withAlphaComponent(0.8)
            case .opaque: return .darkGray
            case let .custom(color): return color
            }
        }
    }
}

private extension FontAttribute {
    func primaryFont(withSize size: CGFloat = UIFont.labelFontSize) -> UIFont {
        switch self {
        case .regular: return .systemFont(ofSize: size)
        case .bold: return .boldSystemFont(ofSize: size)
        case .sBold: return .systemFont(ofSize: size, weight: .semibold)
        case .italic: return .italicSystemFont(ofSize: size)
        }
    }
}

private extension FontStyle {
    var fontSize: CGFloat {
        switch self {
        case .small: return 11
        case .caption: return 12
        case .subhead: return 13
        case .body: return 15
        case .headline: return 18
        case .title: return 22
        case .display: return 26
        case .displayBig: return 32
        }
    }
    
    var font: UIFont {
        return attribute.primaryFont(withSize: fontSize)
    }
}

final class MockTheme: ThemeProtocol {
    var appearanceRules: AppearanceRuleSet = .empty
    
    func color(forSemanticColor semanticColor: SemanticColor) -> UIColor {
        return semanticColor.color
    }
    
    func font(forStyle style: FontStyle) -> UIFont {
        return style.font
    }
    
    func fontSize(forStyle style: FontStyle) -> CGFloat {
        return style.fontSize
    }
    
    func kern(forStyle style: FontStyle) -> CGFloat {
        0
    }
    
    final func cleanThemeCopy() -> MockTheme {
        return MockTheme()
    }
}

final class MockDarkTheme: ThemeProtocol {
    var appearanceRules: AppearanceRuleSet = .empty
    
    func color(forSemanticColor semanticColor: SemanticColor) -> UIColor {
        return semanticColor.color.negative()
    }
    
    func font(forStyle style: FontStyle) -> UIFont {
        return style.font
    }
    
    func fontSize(forStyle style: FontStyle) -> CGFloat {
        return style.fontSize
    }
    
    func kern(forStyle style: FontStyle) -> CGFloat {
        0
    }
    
    final func cleanThemeCopy() -> MockDarkTheme {
        return MockDarkTheme()
    }
}

final class MockWindowsContainer: WindowsContainer {
    var windows: [UIWindow] = []
}
