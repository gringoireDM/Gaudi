//
//  UIColors+Hex.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public extension UIColor {
    static func color(fromHex hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count == 3 {
            cString = cString.map { "\($0)\($0)" }.joined()
        }
        
        guard cString.count == 6 else { return .gray }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func hexValue(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count > 0 else {
            return nil
        }
        
        switch (components.count, alpha) {
        case (1, true):
            let a = Float(1.0)
            let component = lroundf(Float(components[0]) * 255)
            return String(format: "#%02lX%02lX%02lX%02lX", component, component, component, lroundf(a * 255))
        case (1, false), (2, false):
            let component = lroundf(Float(components[0]) * 255)
            return String(format: "#%02lX%02lX%02lX", component, component, component)
        case (2, true):
            let a = lroundf(Float(components[1]) * 255)
            let component = lroundf(Float(components[0]) * 255)
            return String(format: "#%02lX%02lX%02lX%02lX", component, component, component, a)
        case (_, true):
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            let a = components.count >= 4 ? Float(components[3]) : Float(1.0)
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        case (_, false):
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    @available(iOS 13.0, *)
    convenience init(lightColorHex: String, darkColorHex: String) {
        self.init { (traits) -> UIColor in
            switch traits.userInterfaceStyle {
            case .light: return .color(fromHex: lightColorHex)
            case .dark: return .color(fromHex: darkColorHex)
            case .unspecified: return .color(fromHex: lightColorHex)
            @unknown default: return .color(fromHex: lightColorHex)
            }
        }
    }
}
