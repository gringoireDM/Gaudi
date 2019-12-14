//
//  ReversibleTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 10/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class ReversibleTests: XCTestCase {
    func test_it_can_store_original_value() {
        let reversible = Reversible(withOriginalValue: 0)
        XCTAssertEqual(reversible.wrappedValue, 0)
    }
    
    func test_it_can_store_new_value() {
        var reversible = Reversible(withOriginalValue: 0)
        reversible.wrappedValue = 10
        XCTAssertEqual(reversible.wrappedValue, 10)
    }
    
    func test_it_can_revert_to_original_value() {
        var reversible = Reversible(withOriginalValue: 0)
        reversible.wrappedValue = 10
        reversible.revert()
        XCTAssertEqual(reversible.wrappedValue, 0)
    }
    
    func test_it_van_clone_to_reverted_instance() {
        var reversible = Reversible(withOriginalValue: 0)
        reversible.wrappedValue = 10
        let reverted = reversible.reverted()
        XCTAssertEqual(reversible.wrappedValue, 10)
        XCTAssertEqual(reverted.wrappedValue, 0)
    }
}
