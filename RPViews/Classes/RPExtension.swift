//
//  RPExtension.swift
//  RPViews
//
//  Created by Romana on 21/1/21.
//

import Foundation
import UIKit

public extension UIColor{
    var hexCode: String {
        get{
            let colorComponents = self.cgColor.components
            return String(format: "%02x%02x%02x", Int(colorComponents![0]*255.0), Int(colorComponents![1]*255.0),Int(colorComponents![2]*255.0)).uppercased()
        }
    }
    
    //Amount should be between 0 and 1
    func lighterColor(_ amount: CGFloat) -> UIColor{
        return UIColor.blendColors(color: self, destinationColor: UIColor.white, amount: amount)
    }
    
    func darkerColor(_ amount: CGFloat) -> UIColor{
        return UIColor.blendColors(color: self, destinationColor: UIColor.black, amount: amount)
    }
    
    static func blendColors(color: UIColor, destinationColor: UIColor, amount : CGFloat) -> UIColor{
        var amountToBlend = amount;
        if amountToBlend > 1{
            amountToBlend = 1.0
        }
        else if amountToBlend < 0{
            amountToBlend = 0
        }
        
        var r,g,b, alpha : CGFloat
        r = 0
        g = 0
        b = 0
        alpha = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &alpha) //gets the rgba values (0-1)
        
        //Get the destination rgba values
        var dest_r, dest_g, dest_b, dest_alpha : CGFloat
        dest_r = 0
        dest_g = 0
        dest_b = 0
        dest_alpha = 0
        destinationColor.getRed(&dest_r, green: &dest_g, blue: &dest_b, alpha: &dest_alpha)
        
        r = amountToBlend * (dest_r * 255) + (1 - amountToBlend) * (r * 255)
        g = amountToBlend * (dest_g * 255) + (1 - amountToBlend) * (g * 255)
        b = amountToBlend * (dest_b * 255) + (1 - amountToBlend) * (b * 255)
        alpha = abs(alpha / dest_alpha)
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
//            let hexColor = hexString.substring(from: start)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }else{
            
            let scanner = Scanner(string: hexString)
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
            return
        }
        return nil
    }
}
