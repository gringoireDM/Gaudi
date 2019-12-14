//
//  UIColorTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 12/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class UIColorTests: XCTestCase {
    
    func test__a_color__can_be_converted_to_hex() {
        let color = UIColor.black
        XCTAssertEqual(color.hexValue(), "#000000")
    }
    
    func test__a_color__can_be_converted_to_hex__with_alpha() {
        let color = UIColor.black
        XCTAssertEqual(color.hexValue(alpha: true), "#000000FF")
    }
    
    func test__a_clear_color__can_be_converted_to_hex__with_alpha() {
        let color = UIColor.clear
        XCTAssertEqual(color.hexValue(alpha: true), "#00000000")
    }
    
    func test__a_red_color__can_be_converted_to_hex() {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(color.hexValue(), "#FF0000")
    }
    
    func test__a_red_color__can_be_converted_to_hex__with_alpha() {
        let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(color.hexValue(alpha: true), "#FF0000FF")
    }
    
    func test__a_violet_color__can_be_converted_to_hex() {
        let color = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        XCTAssertEqual(color.hexValue(), "#FF00FF")
    }
    
    func test__a_violet_color__can_be_converted_to_hex__with_alpha() {
        let color = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        XCTAssertEqual(color.hexValue(alpha: true), "#FF00FFFF")
    }
    
    func test__an_hex_color__with_hash_symbol__can_be_converted_to_ui_color() {
        let hex = "#000000"
        let color = UIColor.color(fromHex: hex)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = color.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 0)
        XCTAssertEqual(g, 0)
        XCTAssertEqual(b, 0)
    }
    
    func test__an_hex_color__without_hash_symbol__can_be_converted_to_ui_color() {
        let hex = "0000Ff"
        let color = UIColor.color(fromHex: hex)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = color.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 0)
        XCTAssertEqual(g, 0)
        XCTAssertEqual(b, 1)
    }

    func test__an_hex_color__with_three_digit__can_be_converted_to_ui_color() {
        let hex = "FFF"
        let color = UIColor.color(fromHex: hex)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = color.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 1)
        XCTAssertEqual(g, 1)
        XCTAssertEqual(b, 1)
    }
    
    func test__an_hex_color__invalid__can_be_converted_to_gray_color() {
        let hex = "0"
        let color = UIColor.color(fromHex: hex)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = color.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 0.5)
        XCTAssertEqual(g, 0.5)
        XCTAssertEqual(b, 0.5)
    }
    
    @available(iOS 13.0, *)
    func test__a_dynamic_color__can_return_light_color() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        let color = UIColor(lightColorHex: "FFFFFF", darkColorHex: "000000")
        let resolvedColor = color.resolvedColor(with: traitCollection)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = resolvedColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 1)
        XCTAssertEqual(g, 1)
        XCTAssertEqual(b, 1)
    }
    
    @available(iOS 13.0, *)
    func test__a_dynamic_color__can_return_dark_color() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .dark)
        let color = UIColor(lightColorHex: "FFFFFF", darkColorHex: "000000")
        let resolvedColor = color.resolvedColor(with: traitCollection)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = resolvedColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 0)
        XCTAssertEqual(g, 0)
        XCTAssertEqual(b, 0)
    }
    
    @available(iOS 13.0, *)
    func test__a_dynamic_color__can_return_light_color__when_unspecified() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .unspecified)
        let color = UIColor(lightColorHex: "FFFFFF", darkColorHex: "000000")
        let resolvedColor = color.resolvedColor(with: traitCollection)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = resolvedColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 1)
        XCTAssertEqual(g, 1)
        XCTAssertEqual(b, 1)
    }
    
}
