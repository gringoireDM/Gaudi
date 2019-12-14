//
//  UIColor+Utils.swift
//  Gaudi
//
//  Created by Giuseppe Lanza on 13/12/2019.
//  Copyright © 2019 Giuseppe Lanza. All rights reserved.
//

import UIKit

public extension UIColor {
    
    @available(iOS 13.0, *)
    convenience init(lightColor: UIColor, darkColor: UIColor) {
        self.init { (traits) -> UIColor in
            switch traits.userInterfaceStyle {
            case .light: return lightColor
            case .dark: return darkColor
            case .unspecified: return lightColor
            @unknown default: return lightColor
            }
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
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
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
