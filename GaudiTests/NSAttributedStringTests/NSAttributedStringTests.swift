//
//  NSAttributedStringTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 11/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import XCTest

class NSAttributedStringTests: XCTestCase {
    let theme = MockTheme()
    let string = "Frank Sinatra"
    
    func test__it_can_add_foreground_color() {
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: UIColor.green])
        
        let attributedString = string.attributed
            .foregroundColor(.green)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_foreground_color__using_theme() {
        let expected = NSAttributedString(string: string, attributes: [.foregroundColor: theme.color(forSemanticColor: .label(.primary))])
        
        let attributedString = string.attributed
            .foregroundColor(.label(.primary), usingTheme: theme)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_background_color() {
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: UIColor.green])
        
        let attributedString = string.attributed
            .background(.green)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_background_color__using_theme() {
        let expected = NSAttributedString(string: string, attributes: [.backgroundColor: theme.color(forSemanticColor: .fill(.primary))])
        
        let attributedString = string.attributed
            .background(.fill(.primary), usingTheme: theme)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_underline() {
        let expected = NSAttributedString(string: string,
                                          attributes: [
                                            .underlineColor: UIColor.white,
                                            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let attributedString = string.attributed
            .underline(color: .white)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_underline__using_theme() {
        let expected = NSAttributedString(string: string,
                                          attributes: [
                                            .underlineColor: theme.color(forSemanticColor: .label(.primary)),
                                            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let attributedString = string.attributed
            .underline(semanticColor: .label(.primary), usingTheme: theme)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_font() {
        let expected = NSAttributedString(string: string, attributes: [
            .font: UIFont.systemFont(ofSize: 25),
            .kern: 0
        ])
        let attributedString = string.attributed
            .font(.systemFont(ofSize: 25))
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_font__using_theme() {
        let expected = NSAttributedString(string: string, attributes: [
            .font: theme.font(forStyle: .body(attribute: .bold)),
            .kern: theme.kern(forStyle: .body(attribute: .bold))
        ])
        let attributedString = string.attributed
            .font(forStyle: .body(attribute: .bold), kerned: true, usingTheme: theme)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_add_shadow() {
        let shadow = NSShadow()
        let expected = NSAttributedString(string: string, attributes: [.shadow: shadow])
        let attributedString = string.attributed.shadow(shadow)
        XCTAssertEqual(attributedString, expected)
    }

    func test__it_can_change_baseline_offset() {
        let expected = NSAttributedString(string: string, attributes: [.baselineOffset: 10])
        let attributedString = string.attributed.baselineOffset(10)
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_strikethrough() {
        let expected = NSAttributedString(string: string,
                                          attributes: [
                                            .strikethroughColor: UIColor.white,
                                            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let attributedString = string.attributed
            .strikethrough(color: .white)
        
        XCTAssertEqual(attributedString, expected)
    }

    func test__it_can_strikethrough__using_theme() {
        let expected = NSAttributedString(string: string,
                                          attributes: [
                                            .strikethroughColor: theme.color(forSemanticColor: .label(.primary)),
                                            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let attributedString = string.attributed
            .strikethrough(semanticColor: .label(.primary), usingTheme: theme)
        
        XCTAssertEqual(attributedString, expected)
    }
    
    func test__it_can_change_paragraph_style() {
        let style = NSParagraphStyle()
        let expected = NSAttributedString(string: string, attributes: [.paragraphStyle: style])
        let attributedString = string.attributed.paragraphStyle(style)
        XCTAssertEqual(attributedString, expected)
    }
}
