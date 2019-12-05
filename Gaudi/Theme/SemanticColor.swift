//
//  SemanticColor.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

public enum LabelColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case quaternary
    case placeholder
    case link
}

public enum FillColor: CaseIterable {
    case primary
    case secondary
    case tertiary
    case quaternary
    case accent
}

public enum BackgroundColor: CaseIterable {
    case primary
    case secondary
    case tertiary
}

public enum GroupedContentBackgroundColor: CaseIterable {
    case primary
    case secondary
    case tertiary
}

public enum SeparatorColor: CaseIterable {
    case semiTransparent
    case opaque
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
