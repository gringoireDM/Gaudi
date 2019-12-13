//
//  UIColorUtilsTests.swift
//  GaudiTests
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

@testable import Gaudi
import XCTest

extension UIImage {
    func pixelColor(pos: CGPoint = .zero) -> UIColor? {
        guard let image = cgImage,
            let dataProvider = image.dataProvider,
            let pixelData = dataProvider.data else { return nil }
        
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+0]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

class UIColorUtilsTests: XCTestCase {
    
    func test__a_color__can_be_converted_to_image() {
        let expectedRGBA: (CGFloat, CGFloat, CGFloat, CGFloat) = (0.8, 0.5, 0.1, 1)
        let image = UIColor(
            red: expectedRGBA.0,
            green: expectedRGBA.1,
            blue: expectedRGBA.2,
            alpha: expectedRGBA.3
        ).toImage()
        
        XCTAssertEqual(image.size, CGSize(width: 1, height: 1))
        
        let imageColor = image.pixelColor()
        XCTAssertNotNil(imageColor)
        
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        _ = imageColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        XCTAssertEqual(r, expectedRGBA.0, accuracy:  0.01)
        XCTAssertEqual(g, expectedRGBA.1, accuracy:  0.01)
        XCTAssertEqual(b, expectedRGBA.2, accuracy:  0.01)
        XCTAssertEqual(a, expectedRGBA.3, accuracy:  0.01)
    }
    
    func test__a_color__have_a_correct_negative() {
        [UIColor.black, .white, .gray, .green, .yellow, .red, .darkGray, .blue, .cyan]
            .forEach {
                let negative = $0.negative()
                var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
                _ = $0.getRed(&r, green: &g, blue: &b, alpha: nil)

                var (nr, ng, nb): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
                _ = negative.getRed(&nr, green: &ng, blue: &nb, alpha: nil)
                
                XCTAssertEqual(nr, 1-r)
                XCTAssertEqual(ng, 1-g)
                XCTAssertEqual(nb, 1-b)
        }
    }
    
    func test__a_color__can_be_desaturated() {
        [UIColor.black, .white, .gray, .red, .darkGray]
            .forEach {
                var hue: CGFloat = 0
                var brightness: CGFloat = 0
                var alpha: CGFloat = 0
                
                $0.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)

                let desaturated = $0.desaturated()
                
                var dHue: CGFloat = 0
                var dBrightness: CGFloat = 0
                var dSaturation: CGFloat = 0
                var dAlpha: CGFloat = 0
                
                desaturated.getHue(&dHue, saturation: &dSaturation, brightness: &dBrightness, alpha: &dAlpha)
                
                XCTAssertEqual(hue, dHue)
                XCTAssertEqual(dSaturation, 0)
                XCTAssertEqual(brightness, dBrightness)
                XCTAssertEqual(alpha, dAlpha)
        }
    }
    
    func test__a_color__can_be_equated() {
        let color = UIColor.red
        let anotherColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        XCTAssert(color.isSameColorAs(anotherColor))
    }
    
    @available(iOS 13.0, *)
    func test__a_dynamic_color__can_return_light_color() {
        let traitCollection = UITraitCollection(userInterfaceStyle: .light)
        let color = UIColor(lightColor: .white, darkColor: .black)
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
        let color = UIColor(lightColor: .white, darkColor: .black)
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
        let color = UIColor(lightColor: .white, darkColor: .black)
        let resolvedColor = color.resolvedColor(with: traitCollection)
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = resolvedColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        XCTAssertEqual(r, 1)
        XCTAssertEqual(g, 1)
        XCTAssertEqual(b, 1)
    }
}
