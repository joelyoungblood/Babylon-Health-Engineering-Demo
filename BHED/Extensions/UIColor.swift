//
//  UIColor.swift
//  BHED
//
//  Created by Joel Youngblood on 5/25/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner  = Scanner(string: hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        if (hex.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}

extension UIColor {
    static var babylonPink: UIColor {
        return UIColor(hex: "#f45da9")
    }
    
    static var babylonPurple: UIColor {
        return UIColor(hex: "#400199")
    }
    
    static var babylonTeal: UIColor {
        return UIColor(hex: "#24d9d9")
    }
}
