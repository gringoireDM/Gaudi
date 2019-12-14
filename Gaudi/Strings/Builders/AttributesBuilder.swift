//
//  AttributesBuilder.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

@_functionBuilder
public struct AttributesBuilder {
    public static func buildBlock(_ attributes: StringAttributes...) -> StringAttributes {
        attributes.reduce(.empty, +)
    }
    
    public static func buildIf(_ attribute: StringAttributes?) -> StringAttributes {
        attribute ?? .empty
    }
    
    public static func buildEither(first: StringAttributes) -> StringAttributes {
        first
    }
    
    public static func buildEither(second: StringAttributes) -> StringAttributes {
        second
    }
}

public extension StringAttributes {
    init(@AttributesBuilder _ attributes: () -> StringAttributes) {
        self = attributes()
    }
}
