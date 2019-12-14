//
//  FontStyle.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public enum FontAttribute: CaseIterable {
    case regular, bold, sBold, italic
}

public enum FontStyle: CaseIterable {
    case small(attribute: FontAttribute)
    case caption(attribute: FontAttribute)
    case subhead(attribute: FontAttribute)
    case body(attribute: FontAttribute)
    case headline(attribute: FontAttribute)
    case title(attribute: FontAttribute)
    case display(attribute: FontAttribute)
    case displayBig(attribute: FontAttribute)
    
    public var attribute: FontAttribute {
        switch self {
        case let .small(attribute): return attribute
        case let .caption(attribute): return attribute
        case let .subhead(attribute): return attribute
        case let .body(attribute): return attribute
        case let .headline(attribute): return attribute
        case let .title(attribute): return attribute
        case let .display(attribute): return attribute
        case let .displayBig(attribute): return attribute
        }
    }
    
    public static var allCases: [FontStyle] {
        return FontAttribute.allCases.flatMap {
            [
                .small(attribute: $0),
                .caption(attribute: $0),
                .subhead(attribute: $0),
                .body(attribute: $0),
                .headline(attribute: $0),
                .title(attribute: $0),
                .display(attribute: $0),
                .displayBig(attribute: $0)
            ]
        }
    }
}
