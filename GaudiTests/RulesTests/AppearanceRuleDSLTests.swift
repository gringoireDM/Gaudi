//
//  AppearanceRuleDSL.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 10/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class AppearanceRuleDSLTests: XCTestCase {
    func test__it_can_build_an_empty_ruleset() {
        let set = AppearanceRuleSet.empty
        XCTAssert(set.rules.isEmpty)
    }
    
    func test__it_can_build_single_rule() {
        let set = AppearanceRuleSet {
            UITextField[\.tintColor, .black]
        }
        XCTAssertEqual(set.rules.count, 1)
    }
    
    func test__it_can_build_multiple_rules() {
        let set = AppearanceRuleSet {
            UITextField[\.tintColor, .black]
            UITextField[\.textColor, .white]
        }
        XCTAssertEqual(set.rules.count, 2)
    }
    
    func test__it_can_build_nested_sets() {
        let set = AppearanceRuleSet {
            UITextField[\.tintColor, .black]
            AppearanceRuleSet {
                UITextField[\.textColor, .white]
            }
        }
        
        XCTAssertEqual(set.rules.count, 2)
        XCTAssertNotNil(set.rules.last as? AppearanceRuleSet)
    }
    
    func test__it_can_exclude_failing_if() {
        let check = false
        let set = AppearanceRuleSet {
            if check {
                UITextField[\.tintColor, .black]
            }
        }
        XCTAssert(set.rules.isEmpty)
    }
    
    func test__it_can_build_if() {
        let set = AppearanceRuleSet {
            if true {
                UITextField[\.tintColor, .black]
            }
        }
        XCTAssertEqual(set.rules.count, 1)
    }
    
    func test_it_can_build_if_else_first() {
        let check = true
        let set = AppearanceRuleSet {
            if check {
                UITextField[\.tintColor, .black]
            } else {
                UITextField[\.textColor, .white]
            }
        }
        
        XCTAssertEqual(set.rules.count, 1)
        guard let rule = set.rules.first as? PropertyAppearanceRule<UITextField, UIColor?> else {
            XCTFail()
            return
        }
        XCTAssertEqual(rule, PropertyAppearanceRule(keypath: \.tintColor, value: .black) )
    }
    
    func test_it_can_build_if_else_second() {
        let check = false
        let set = AppearanceRuleSet {
            if check {
                UITextField[\.tintColor, .black]
            } else {
                UITextField[\.textColor, .white]
            }
        }
        
        XCTAssertEqual(set.rules.count, 1)
        guard let rule = set.rules.first as? PropertyAppearanceRule<UITextField, UIColor?> else {
            XCTFail()
            return
        }
        XCTAssertEqual(rule, PropertyAppearanceRule(keypath: \.textColor, value: .white) )
    }
}
