//
//  ThemeProtocol.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

/// This protocol should be adopted by those ViewControllers
///that are meant to be themed
public protocol Themed: UITraitEnvironment {
    func applyTheme()
}

public protocol ThemeProtocol: class {
    var appearanceRules: AppearanceRuleSet { get }
        
    // MARK: Colors
    
    func color(forSemanticColor semanticColor: SemanticColor) -> UIColor
    
    // MARK: Fonts
    
    func font(forStyle style: FontStyle) -> UIFont
    func fontSize(forStyle style: FontStyle) -> CGFloat
    func kern(forStyle style: FontStyle) -> CGFloat
}
