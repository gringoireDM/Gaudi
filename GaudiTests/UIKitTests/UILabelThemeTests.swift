//
//  UILabelThemeTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

class UILabelThemeTests: XCTestCase {
    let theme = MockTheme()
    func test__it_can_apply_label_style__to_label() {
        let label = UILabel()
        for fontStyle in FontStyle.allCases {
            let expectedFont = theme.font(forStyle: fontStyle)
            for semanticColor in SemanticColor.allCases {
                let expectedColor = theme.color(forSemanticColor: semanticColor)
                
                label.applyLabelStyle(fontStyle, semanticColor: semanticColor, usingTheme: theme)
                
                XCTAssertEqual(label.font, expectedFont)
                XCTAssertEqual(label.textColor, expectedColor)
            }
        }
    }
    
    func test__it_can_apply_label_style__to_array_of_labels() {
        let labels = [UILabel(), UILabel()]
        for fontStyle in FontStyle.allCases {
            let expectedFont = theme.font(forStyle: fontStyle)
            for semanticColor in SemanticColor.allCases {
                let expectedColor = theme.color(forSemanticColor: semanticColor)
                
                labels.applyLabelsStyle(fontStyle, semanticColor: semanticColor, usingTheme: theme)
                
                for label in labels {
                    XCTAssertEqual(label.font, expectedFont)
                    XCTAssertEqual(label.textColor, expectedColor)
                }
            }
        }
    }

}
