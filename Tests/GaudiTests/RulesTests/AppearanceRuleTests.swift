//
//  AppearanceRuleTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 10/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class AppearanceRuleTests: XCTestCase {

    func test__a_property_rule__can_apply_appearance() {
        let rule = PropertyAppearanceRule(keypath: \UINavigationBar.barTintColor, value: .black)
        rule.apply()
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, .black)
    }
    
    func test__a_property_rule__created_with_subscript__can_apply_appearance() {
        let rule = UINavigationBar[\.barTintColor, .black]
        rule.apply()
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, .black)
    }
    
    func test__a_property_rule__can_revert_appearance() {
        let originalValue = UINavigationBar.appearance().barTintColor
        let rule = PropertyAppearanceRule(keypath: \UINavigationBar.barTintColor, value: .black)
        rule.apply()
        rule.revert()
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, originalValue)
    }
    
    func test__a_property_rule__created_with_subscript__can_revert_appearance() {
        let originalValue = UINavigationBar.appearance().barTintColor
        let rule = UINavigationBar[\.barTintColor, .black]
        rule.apply()
        rule.revert()
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, originalValue)
    }
    
    func test__a_selector_rule__can_apply_appearance() {
        let rule = SelectorAppearanceRule<UIButton, UIColor?>(
            get: { $0.titleColor(for: .selected) },
            set: { $0.setTitleColor($1, for: .selected) },
            value: .white
        )
        rule.apply()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), .white)
    }
    
    func test__a_selector_rule__created_with_subscript__can_apply_appearance() {
        let rule = UIButton[
            get: { $0.titleColor(for: .selected) },
            set: { $0.setTitleColor($1, for: .selected) },
            value: .white
        ]
        rule.apply()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), .white)
    }
    
    func test__a_selector_rule__can_revert_appearance() {
        let originalValue = UIButton.appearance().titleColor(for: .selected)
        let rule = SelectorAppearanceRule<UIButton, UIColor?>(
            get: { $0.titleColor(for: .selected) },
            set: { $0.setTitleColor($1, for: .selected) },
            value: .white
        )
        rule.apply()
        rule.revert()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), originalValue)
    }
    
    func test__a_selector_rule__created_with_subscript__can_revert_appearance() {
        let originalValue = UIButton.appearance().titleColor(for: .selected)
        let rule = UIButton[
            get: { $0.titleColor(for: .selected) },
            set: { $0.setTitleColor($1, for: .selected) },
            value: .white
        ]
        rule.apply()
        rule.revert()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), originalValue)
    }
    
    func test__a_rule_set__can_apply_appearances() {
        let ruleSet = AppearanceRuleSet(rules: [
            PropertyAppearanceRule(keypath: \UINavigationBar.barTintColor, value: .black),
            SelectorAppearanceRule<UIButton, UIColor?>(
                get: { $0.titleColor(for: .selected) },
                set: { $0.setTitleColor($1, for: .selected) },
                value: .white
            )
        ])
        ruleSet.apply()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), .white)
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, .black)
    }
    
    func test__a_rule_set__created_with_dsl__can_apply_appearances() {
        let ruleSet = AppearanceRuleSet {
            UINavigationBar[\.barTintColor, .black]
            UIButton[
                get: { $0.titleColor(for: .selected) },
                set: { $0.setTitleColor($1, for: .selected) },
                value: .white
            ]
        }
        ruleSet.apply()
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), .white)
        XCTAssertEqual(UINavigationBar.appearance().barTintColor, .black)
    }
    
    func test__a_rule_set__can_revert_appearances() {
        let originalNavBarValue = UINavigationBar.appearance().barTintColor
        let originalButtonValue = UIButton.appearance().titleColor(for: .selected)
        let ruleSet = AppearanceRuleSet(rules: [
            PropertyAppearanceRule(keypath: \UINavigationBar.barTintColor, value: .black),
            SelectorAppearanceRule<UIButton, UIColor?>(
                get: { $0.titleColor(for: .selected) },
                set: { $0.setTitleColor($1, for: .selected) },
                value: .white
            )
        ])
        ruleSet.apply()
        ruleSet.revert()

        XCTAssertEqual(UINavigationBar.appearance().barTintColor, originalNavBarValue)
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), originalButtonValue)
    }
    
    func test__a_rule_set__created_with_dsl__can_revert_appearances() {
        let originalNavBarValue = UINavigationBar.appearance().barTintColor
        let originalButtonValue = UIButton.appearance().titleColor(for: .selected)
        let ruleSet = AppearanceRuleSet {
            UINavigationBar[\.barTintColor, .black]
            UIButton[
                get: { $0.titleColor(for: .selected) },
                set: { $0.setTitleColor($1, for: .selected) },
                value: .white
            ]
        }
        ruleSet.apply()
        ruleSet.revert()

        XCTAssertEqual(UINavigationBar.appearance().barTintColor, originalNavBarValue)
        XCTAssertEqual(UIButton.appearance().titleColor(for: .selected), originalButtonValue)
    }
    
}
