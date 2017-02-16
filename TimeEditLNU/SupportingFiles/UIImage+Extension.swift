//
//  UIImage+Extension.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/13/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
