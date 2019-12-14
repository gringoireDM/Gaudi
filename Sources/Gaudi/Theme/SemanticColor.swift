//
//  SemanticColor.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public enum LabelColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case quaternary
    case placeholder
    case link
    case custom(color: UIColor)
    
    public static var allCases: [LabelColor] {
        return [.primary, .secondary, .tertiary, .quaternary, .placeholder, .link]
    }
}

public enum FillColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case quaternary
    case accent
    case custom(color: UIColor)
    
    public static var allCases: [FillColor] {
        return [.primary, .secondary, .tertiary, .quaternary, .accent]
    }

}

public enum BackgroundColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case custom(color: UIColor)
    
    public static var allCases: [BackgroundColor] {
        return [.primary, .secondary, .tertiary]
    }
}

public enum GroupedContentBackgroundColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case custom(color: UIColor)
    
    public static var allCases: [GroupedContentBackgroundColor] {
        return [.primary, .secondary, .tertiary]
    }
}

public enum SeparatorColor: CaseIterable {
    case semiTransparent
    case opaque
    case custom(color: UIColor)
    
    public static var allCases: [SeparatorColor] {
        return [.semiTransparent, .opaque]
    }
}


public enum SemanticColor: CaseIterable {
    case label(LabelColor)
    case fill(FillColor)
    case background(BackgroundColor)
    case groupedBackground(GroupedContentBackgroundColor)
    case separator(SeparatorColor)
    
    public static var allCases: [SemanticColor] {
        return LabelColor.allCases.map { .label($0) } +
            FillColor.allCases.map { .fill($0) } +
            BackgroundColor.allCases.map { .background($0) } +
            GroupedContentBackgroundColor.allCases.map { .groupedBackground($0) } +
            SeparatorColor.allCases.map { .separator($0) }
    }
}
