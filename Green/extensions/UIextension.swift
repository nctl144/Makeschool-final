//
//  UIextension.swift
//  Green
//
//  Created by Nguyễn Lâm on 7/19/17.
//  Copyright © 2017 lam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBackground(imageName: String, contentMode: UIViewContentMode) {
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: imageName)
        
        // you can change the content mode:
        imageViewBackground.contentMode = contentMode
        imageViewBackground.clipsToBounds = true
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(imageViewBackground, at: 0)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[imageViewBackground]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["imageViewBackground": imageViewBackground]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageViewBackground]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["imageViewBackground": imageViewBackground]))
    }
}

// convert hex color to uicolor
extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.trimmingCharacters(in: .whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
