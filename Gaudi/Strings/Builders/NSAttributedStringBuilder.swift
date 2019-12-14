//
//  NSAttributedStringBuilder.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

@_functionBuilder
public struct NSAttributedStringBuilder {
    public static func buildBlock(_ segments: NSAttributedString...) -> NSAttributedString {
        segments.reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
    
    public static func buildIf(_ segment: NSAttributedString?) -> NSAttributedString {
        segment ?? NSAttributedString()
    }
    
    public static func buildEither(first: NSAttributedString) -> NSAttributedString {
        first
    }
    
    public static func buildEither(second: NSAttributedString) -> NSAttributedString {
        second
    }
}

public extension NSAttributedString {
    convenience init(@NSAttributedStringBuilder _ content: () -> NSAttributedString) {
        self.init(attributedString: content())
    }
    
    convenience init(string: String, @AttributesBuilder attributes: () -> StringAttributes) {
        self.init(string: string, attributes: attributes().attributes)
    }
    
    func addingAttributes(forRange range: NSRange, @AttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        let res = NSMutableAttributedString(attributedString: self)
        res.addAttributes(attributes().attributes, range: range)
        return res
    }
}

public extension NSMutableAttributedString {
    func addAttributes(forRange range: NSRange, @AttributesBuilder attributes: () -> StringAttributes) {
        addAttributes(attributes().attributes, range: range)
    }
}
