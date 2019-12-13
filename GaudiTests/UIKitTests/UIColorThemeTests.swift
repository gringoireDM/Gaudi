//
//  UIColorThemeTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class UIColorThemeTests: XCTestCase {
    let theme = MockTheme()
    func test__it_can_get_color__from_semantic_color() {
        let expectedColors = SemanticColor.allCases
            .map { theme.color(forSemanticColor: $0) }
        XCTAssertEqual(
            expectedColors,
            SemanticColor.allCases
                .map { .semanticColor($0, usingTheme: theme) }
        )
    }
}
