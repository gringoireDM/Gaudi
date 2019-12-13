//
//  UIfontThemeTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class UIfontThemeTests: XCTestCase {
    
    let theme = MockTheme()
    func test__it_can_get_font__from_font_style() {
        let expectedFonts = FontStyle.allCases
            .map { theme.font(forStyle: $0) }
        XCTAssertEqual(
            expectedFonts,
            FontStyle.allCases
                .map { .font(forStyle: $0, usingTheme: theme) }
        )
    }

}
