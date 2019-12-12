//
//  SringAttributesTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 12/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class SringAttributesTests: XCTestCase {
    let theme = MockTheme()
    
    func test__it_can_form_foreground_color_attributes() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.green] as NSDictionary
        
        let attributes = StringAttributes
            .foreground(color: .green)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_foreground_color_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.foregroundColor: theme.color(forSemanticColor: .label(.primary))
        ] as NSDictionary
        
        let attributes = StringAttributes
            .foreground(semanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_background_color_attributes() {
        let expected = [NSAttributedString.Key.backgroundColor: UIColor.green] as NSDictionary
        
        let attributes = StringAttributes
            .background(color: .green)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_background_color_attributes__using_theme() {
        let expected = [NSAttributedString.Key.backgroundColor: theme.color(forSemanticColor: .fill(.primary))] as NSDictionary
        
        let attributes = StringAttributes
            .background(semanticColor: .fill(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_underline_attributes() {
        let expected = [
            NSAttributedString.Key.underlineColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = StringAttributes
            .underline(color: .white)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_underline_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.underlineColor: theme.color(forSemanticColor: .label(.primary)),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = StringAttributes
            .underline(semanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_font_attributes() {
        let expected = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25),
            .kern: 0
        ] as NSDictionary
        let attributes = StringAttributes
            .font(.systemFont(ofSize: 25))
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_font_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.font: theme.font(forStyle: .body(attribute: .bold)),
            .kern: theme.kern(forStyle: .body(attribute: .bold))
        ] as NSDictionary
        let attributes = StringAttributes
            .font(forStyle: .body(attribute: .bold), kerned: true, usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_shadow_attributes() {
        let shadow = NSShadow()
        let expected = [NSAttributedString.Key.shadow: shadow] as NSDictionary
        let attributes = StringAttributes.shadow(shadow)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }

    func test__it_can_form_baseline_offset_attributes() {
        let expected = [NSAttributedString.Key.baselineOffset: 10] as NSDictionary
        let attributes = StringAttributes.baselineOffset(10)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_strikethrough_attributes() {
        let expected = [
            NSAttributedString.Key.strikethroughColor: UIColor.white,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = StringAttributes
            .strikethrough(color: .white)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }

    func test__it_can_form_strikethrough_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.strikethroughColor: theme.color(forSemanticColor: .label(.primary)),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = StringAttributes
            .strikethrough(semanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_paragraph_style_attributes() {
        let style = NSParagraphStyle()
        let expected = [NSAttributedString.Key.paragraphStyle: style] as NSDictionary
        let attributes = StringAttributes
            .paragraphStyle(style)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_sum_two_attributes() {
        let expected = [
            NSAttributedString.Key.foregroundColor: UIColor.green,
            .backgroundColor: UIColor.red
        ] as NSDictionary
        
        let attributes = (
            StringAttributes.foreground(color: .green) +
                StringAttributes.background(color: .red)
            ).attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
}
