//
//  NSAttributedStringBuilderTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 11/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class NSAttributedStringDSLTests: XCTestCase {
    let string = "Frank"
    let secondString = " Sinatra"
    
    func test__it_can_build_attributed_strings__with_single_string() {
        let expected = NSAttributedString(string: string)
        let attributedString = NSAttributedString {
            string.attributed
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_multiple_strings() {
        let first = NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.white
        ])
        let second = NSAttributedString(string: secondString, attributes: [
            .foregroundColor: UIColor.red
        ])
        let expected = NSMutableAttributedString(attributedString: first)
        expected.append(second)
        
        let attributedString = NSAttributedString {
            string.foregroundColor(.white)
            secondString.foregroundColor(.red)
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_single_if() {
        let expected = NSAttributedString(string: string)
        let attributedString = NSAttributedString {
            if true {
                string.attributed
            }
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_single_failing_if() {
        let expected = NSAttributedString()
        let check = false
        let attributedString = NSAttributedString {
            if check {
                string.attributed
            }
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_multiple_strings_and_if() {
        let expected = NSAttributedString(string: string + secondString)
        let attributedString = NSAttributedString {
            string.attributed
            if true {
                secondString.attributed
            }
        }
        XCTAssertEqual(attributedString, expected)
    }

    func test__it_can_build_attributed_strings__with_multiple_strings_and_failing_if() {
        let expected = NSAttributedString(string: string)
        let check = false
        let attributedString = NSAttributedString {
            string.attributed
            if check {
                secondString.attributed
            }
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_multiple_strings_and_if_else_first() {
        let expected = NSAttributedString(string: string + secondString)
        let check = true
        let attributedString = NSAttributedString {
            string.attributed
            if check {
                secondString.attributed
            } else {
                secondString.foregroundColor(.red)
            }
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_build_attributed_strings__with_multiple_strings_and_if_else_second() {
        let first = NSAttributedString(string: string)
        let second = NSAttributedString(string: secondString, attributes: [
            .foregroundColor: UIColor.red
        ])
        let expected = NSMutableAttributedString(attributedString: first)
        expected.append(second)

        let check = false
        let attributedString = NSAttributedString {
            string.attributed
            if check {
                secondString.attributed
            } else {
                secondString.foregroundColor(.red)
            }
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_attriutes__to_existing_attributed_string() {
        let expected = NSAttributedString(string: string + secondString, attributes: [
            .foregroundColor: UIColor.red
        ])
        let range = NSRange(location: 0, length: (string + secondString).count)
        let attributedString = (string + secondString).attributed
            .addingAttributes(forRange: range) {
                StringAttributes.foregroundColor(.red)
        }
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_attriutes__to_existing_mutable_attributed_string() {
        let expected = NSAttributedString(string: string + secondString, attributes: [
            .foregroundColor: UIColor.red
        ])
        let range = NSRange(location: 0, length: (string + secondString).count)
        let attributedString = NSMutableAttributedString(string: string + secondString)
        attributedString.addAttributes(forRange: range) {
                StringAttributes.foregroundColor(.red)
        }
        XCTAssertEqual(attributedString, expected)
    }
}
