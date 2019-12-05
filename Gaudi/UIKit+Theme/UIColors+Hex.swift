//
//  UIColors+Hex.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

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
    
    func negative() -> UIColor {
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        _ = getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red: 1 - r, green: 1 - g, blue: 1 - b, alpha: 1)
    }
    
    func desaturated() -> UIColor {
        var hue: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        
        return UIColor(hue: hue, saturation: 0, brightness: brightness, alpha: alpha)
    }
    
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func isSameColorAs(_ color: UIColor) -> Bool {
        var (selfR, selfG, selfB): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        
        _ = getRed(&selfR, green: &selfG, blue: &selfB, alpha: nil)
        _ = color.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        return selfR == r && selfG == g && selfB == b
    }
}
