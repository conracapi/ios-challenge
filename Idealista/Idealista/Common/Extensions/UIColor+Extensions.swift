//
//  UIColor+Extensions.swift
//  Idealista
//
//  Created by Conrado Capilla García on 26/11/24.
//

import UIKit


extension UIColor {
    
    static var mainBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ? UIColor(hex: "#323232") : UIColor(hex: "#EEE9D6")
            }
        }
    }
    
    static var adCellBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ? UIColor(hex: "#222222") : UIColor(hex: "#FFFFFF")
            }
        }
    }
    
    static var adText: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ? UIColor(hex: "#FFFFFF") : UIColor(hex: "#222222")
            }
        }
    }
    
    static var greenBrand: UIColor = UIColor(hex: "#E1F66D")
    
    
    
    
    
    
    
    
    // MARK: - Initializer: set color as rgb
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var correctHex = hexString
        
        if hexString.hasPrefix("#") {
            correctHex = String(hexString.dropFirst())
        }
        
        guard correctHex.count == 6, let hexNumber = Int(correctHex, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)  // black color
            return
        }
        
        let mask = 0x000000FF
        let r = (hexNumber >> 16) & mask
        let g = (hexNumber >> 8) & mask
        let b = hexNumber & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    
}
