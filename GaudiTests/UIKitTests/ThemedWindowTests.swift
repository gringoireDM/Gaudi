//
//  ThemedWindowTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class ThemedWindowTests: XCTestCase {
    let semanticColors = SemanticColor.allCases
    
    let lightTheme = MockTheme()
    let darkTheme = MockDarkTheme()
    
    var window: ThemedWindow!
    var rootViewController: MockViewController!
    var windowsContainer: MockWindowsContainer!
    
    override func setUp() {
        super.setUp()
        windowsContainer = MockWindowsContainer()
        rootViewController = MockViewController()
        window = ThemedWindow(lightTheme: lightTheme, darkTheme: darkTheme)
        window.rootViewController = rootViewController
        
        windowsContainer.windows.append(window)
        
        ThemeContainer.windowsContainer = windowsContainer
    }
    
    override func tearDown() {
        super.tearDown()
        window = nil
        rootViewController = nil
        windowsContainer = nil
        ThemeContainer.windowsContainer = UIApplication.shared
        ThemeContainer.currentTheme = nil
        
        if #available(iOS 13.0, *) {
            let traitCollection = UITraitCollection(userInterfaceStyle: .unspecified)
            UITraitCollection.current = traitCollection
        }
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__is_light__for_light_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        UITraitCollection.current = traitCollection
                
        XCTAssertEqual(
            semanticColors.map { lightTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__is_light__for_unspecified_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .unspecified)
        UITraitCollection.current = traitCollection
                
        XCTAssertEqual(
            semanticColors.map { lightTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }

    @available(iOS 13.0, *)
    func test__current_theme__is_dark__for_dark_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        UITraitCollection.current = traitCollection
                
        XCTAssertEqual(
            semanticColors.map { darkTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
    
    func test__current_theme__can_be_switched__for_light_mode() {
        let otherTheme = OtherMockTheme()
        window.lightTheme = otherTheme
        
        XCTAssertEqual(
            semanticColors.map { otherTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
        
        XCTAssert(ThemeContainer.currentTheme === otherTheme)
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__cant_be_switched__for_light_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        UITraitCollection.current = traitCollection
        
        let otherTheme = OtherMockTheme()
        window.lightTheme = otherTheme
        
        XCTAssertEqual(
            semanticColors.map { darkTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__can_be_switched__for_dark_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        UITraitCollection.current = traitCollection
        
        let otherTheme = OtherMockTheme()
        window.darkTheme = otherTheme
        
        XCTAssertEqual(
            semanticColors.map { otherTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
        XCTAssert(ThemeContainer.currentTheme === otherTheme)
    }
    
    @available(iOS 13.0, *)
    func test__current_theme__cant_be_switched__for_dark_mode() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        UITraitCollection.current = traitCollection
        
        let otherTheme = OtherMockTheme()
        window.darkTheme = otherTheme
        
        XCTAssertEqual(
            semanticColors.map { lightTheme.color(forSemanticColor: $0) },
            semanticColors.map { window.currentTheme.color(forSemanticColor: $0) }
            )
    }
    
    @available(iOS 13.0, *)
    func test__light_theme__is_applied__on_trait_change() {
        let previous = UITraitCollection.current
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        UITraitCollection.current = traitCollection
        
        window.traitCollectionDidChange(previous)
        XCTAssert(ThemeContainer.currentTheme === lightTheme)
    }
    
    @available(iOS 13.0, *)
    func test__dark_theme__is_applied__on_trait_change() {
        let previous = UITraitCollection.current
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        UITraitCollection.current = traitCollection
        
        window.traitCollectionDidChange(previous)
        XCTAssert(ThemeContainer.currentTheme === darkTheme)
    }
}
