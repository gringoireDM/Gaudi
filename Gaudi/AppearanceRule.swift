//
//  AppearanceRule.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

@propertyWrapper
public struct Reversible<Value> {
    public let original: Value
    private var _value: Value?
    public var wrappedValue: Value {
        get { return _value ?? original }
        set { _value = newValue }
    }
    
    public init(withOriginalValue value: Value) {
        original = value
    }
    
    public init(withOriginalValue original: Value, andValue value: Value) {
        self.original = original
        _value = value
    }
    
    public mutating func revert() {
        _value = nil
    }
    
    public func reverted() -> Self {
        Reversible(withOriginalValue: original)
    }
}

public protocol AppearanceRuleProtocol {
    func apply()
    func revert()
}

public struct PropertyAppearanceRule<T: UIAppearance, Value>: AppearanceRuleProtocol {
    @Reversible private var value: Value
    let keypath: WritableKeyPath<T, Value>
    
    public init(keypath: WritableKeyPath<T, Value>, value: Value) {
        let proxy = T.appearance()
        self.keypath = keypath
        _value = Reversible(withOriginalValue: proxy[keyPath: keypath], andValue: value)
    }
    
    public func apply() {
        var proxy = T.appearance()
        proxy[keyPath: keypath] = value
    }
    
    public func revert() {
        var proxy = T.appearance()
        proxy[keyPath: keypath] = _value.reverted().wrappedValue
    }
}

public class SelectorAppearanceRule<T: UIAppearance, Value>: AppearanceRuleProtocol {
    @Reversible private var value: Value
    
    private let getter: (T) -> Value
    private let setter: (T, Value) -> Void
    
    init(get: @escaping (T) -> Value, set: @escaping (T, Value) -> Void, value: Value) {
        let proxy = T.appearance()
        _value = Reversible(withOriginalValue: get(proxy), andValue: value)
        getter = get
        setter = set
    }
    
    public func apply() {
        let proxy = T.appearance()
        setter(proxy, value)
    }
    
    public func revert() {
        let proxy = T.appearance()
        setter(proxy, _value.reverted().wrappedValue)
    }
}

public struct AppearanceRuleSet: AppearanceRuleProtocol {
    public static let empty: AppearanceRuleSet = AppearanceRuleSet(rules: [])
    
    let rules: [AppearanceRuleProtocol]
    public init(@AppearanceBuilder builder: () -> [AppearanceRuleProtocol]) {
        rules = builder()
    }
    
    public init(rules: [AppearanceRuleProtocol]) {
        self.rules = rules
    }
    
    public func apply() {
        rules.forEach { $0.apply() }
    }
    
    public func revert() {
        rules.forEach { $0.revert() }
    }
}

public func + (lhs: AppearanceRuleSet, rhs: AppearanceRuleSet) -> AppearanceRuleSet {
    AppearanceRuleSet(rules: lhs.rules + rhs.rules)
}

@_functionBuilder
public struct AppearanceBuilder {
    public static func buildBlock(_ rules: AppearanceRuleProtocol...) -> [AppearanceRuleProtocol] {
        rules
    }
}

public extension UIAppearance {
    static subscript<Value>(rule: WritableKeyPath<Self, Value>, value: Value) -> AppearanceRuleProtocol {
        PropertyAppearanceRule(keypath: rule, value: value)
    }
    
    static subscript<Value>(get getter: @escaping (Self) -> Value, set setter: @escaping (Self, Value) -> Void, value val: Value) -> AppearanceRuleProtocol {
        SelectorAppearanceRule(get: getter, set: setter, value: val)
    }
}
