//
//  SringAttributesTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 12/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest
import UIKit

class SringAttributesTests: XCTestCase {
    let theme = MockTheme()
    
    func test__it_can_form_foreground_color_attributes() {
        let expected = [NSAttributedString.Key.foregroundColor: UIColor.green] as NSDictionary
        
        let attributes = foregroundAttribute(withColor: .green)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_foreground_color_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.foregroundColor: theme.color(forSemanticColor: .label(.primary))
        ] as NSDictionary
        
        let attributes = foregroundAttribute(withSemanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_background_color_attributes() {
        let expected = [NSAttributedString.Key.backgroundColor: UIColor.green] as NSDictionary
        
        let attributes = backgroundAttribute(withColor: .green)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_background_color_attributes__using_theme() {
        let expected = [NSAttributedString.Key.backgroundColor: theme.color(forSemanticColor: .fill(.primary))] as NSDictionary
        
        let attributes = backgroundAttribute(withSemanticColor: .fill(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_underline_attributes() {
        let expected = [
            NSAttributedString.Key.underlineColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = underlineAttribute(withColor: .white)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_underline_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.underlineColor: theme.color(forSemanticColor: .label(.primary)),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = underlineAttribute(withSemanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_font_attributes() {
        let expected = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25),
            .kern: 0
        ] as NSDictionary
        let attributes = fontAttribute(withFont: .systemFont(ofSize: 25))
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_font_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.font: theme.font(forStyle: .body(attribute: .bold)),
            .kern: theme.kern(forStyle: .body(attribute: .bold))
        ] as NSDictionary
        let attributes = fontAttribute(withStyle: .body(attribute: .bold), kerned: true, usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_shadow_attributes() {
        let shadow = NSShadow()
        let expected = [NSAttributedString.Key.shadow: shadow] as NSDictionary
        let attributes = Gaudi.shadowAttribute(withShadow: shadow)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }

    func test__it_can_form_baseline_offset_attributes() {
        let expected = [NSAttributedString.Key.baselineOffset: 10] as NSDictionary
        let attributes = baselineOffsetAttribute(withOffset: 10)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_strikethrough_attributes() {
        let expected = [
            NSAttributedString.Key.strikethroughColor: UIColor.white,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = strikethroughAttribute(withColor: .white)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }

    func test__it_can_form_strikethrough_attributes__using_theme() {
        let expected = [
            NSAttributedString.Key.strikethroughColor: theme.color(forSemanticColor: .label(.primary)),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ] as NSDictionary
        
        let attributes = strikethroughAttribute(withSemanticColor: .label(.primary), usingTheme: theme)
            .attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_form_paragraph_style_attributes() {
        let style = NSParagraphStyle()
        let expected = [NSAttributedString.Key.paragraphStyle: style] as NSDictionary
        let attributes = paragraphStyleAttribute(withStyle: style)
            .attributes as NSDictionary
        XCTAssertEqual(attributes, expected)
    }
    
    func test__it_can_sum_two_attributes() {
        let expected = [
            NSAttributedString.Key.foregroundColor: UIColor.green,
            .backgroundColor: UIColor.red
        ] as NSDictionary
        
        let attributes = (
            foregroundAttribute(withColor: .green) +
                backgroundAttribute(withColor: .red)
            ).attributes as NSDictionary
        
        XCTAssertEqual(attributes, expected)
    }
}
