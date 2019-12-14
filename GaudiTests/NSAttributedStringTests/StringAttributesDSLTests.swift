//
//  StringAttributesDSLTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 12/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class StringAttributesDSLTests: XCTestCase {
    func test__it_can_build__one_attribute() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.green] as NSDictionary

        let attributes = StringAttributes {
            foregroundAttribute(withColor: .green)
        }.attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_build__multiple_attributes() {
        let expected = [
            NSAttributedString.Key.foregroundColor: UIColor.green,
            .backgroundColor: UIColor.red
            ] as NSDictionary

        let attributes = StringAttributes {
            foregroundAttribute(withColor: .green)
            backgroundAttribute(withColor: .red)
        }.attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_build_attributes__with_if() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.green] as NSDictionary

        let attributes = StringAttributes {
            if true {
                foregroundAttribute(withColor: .green)
            }
        }.attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_build_attributes__with_failing_if() {
        let check = false
        let attributes = StringAttributes {
            if check {
                foregroundAttribute(withColor: .green)
            }
        }.attributes as NSDictionary
        
        XCTAssertEqual(attributes, [:] as NSDictionary)
    }
    
    func test__it_can_build_attributes__with_if_else_first() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.green] as NSDictionary

        let check = true
        let attributes = StringAttributes {
            if check {
                foregroundAttribute(withColor: .green)
            } else {
                foregroundAttribute(withColor: .blue)
            }
        }.attributes
        
        XCTAssertEqual(attributes as NSDictionary, expected)
    }
    
    func test__it_can_build_attributes__with_if_else_second() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.blue] as NSDictionary

        let check = false
        let attributes = StringAttributes {
            if check {
                foregroundAttribute(withColor: .green)
            } else {
                foregroundAttribute(withColor: .blue)
            }
        }.attributes
        
        XCTAssertEqual(attributes as NSDictionary, expected)
    }
}
