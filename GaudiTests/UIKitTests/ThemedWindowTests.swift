//
//  ThemedWindowTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class ThemedWindowTests: XCTestCase {
    let lightTheme = MockTheme()
    let darkTheme = MockDarkTheme()
    
    var window: ThemedWindow!
    override func setUp() {
        super.setUp()
        window = ThemedWindow(lightTheme: lightTheme, darkTheme: darkTheme)
    }
    
    override func tearDown() {
        super.tearDown()
        window = nil
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__is_light__for_light_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        UITraitCollection.current = traitCollection
        
        let semanticColors = SemanticColor.allCases
        
        XCTAssertEqual(
            semanticColors.map { lightTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__is_light__for_unspecified_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .unspecified)
        UITraitCollection.current = traitCollection
        
        let semanticColors = SemanticColor.allCases
        
        XCTAssertEqual(
            semanticColors.map { lightTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }

    @available(iOS 13.0, *)
    func test__current_theme__is_dark__for_dark_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        UITraitCollection.current = traitCollection
        
        let semanticColors = SemanticColor.allCases
        
        XCTAssertEqual(
            semanticColors.map { darkTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
}
