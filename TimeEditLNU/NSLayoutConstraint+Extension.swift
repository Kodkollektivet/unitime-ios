//
//  NSLayoutConstraint+Extension.swift
//  Setzy
//
//  Created by Alper Gündogdu on 01/08/16.
//  Copyright © 2016 Peakode. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    public class func applyAutoLayout(superview: UIView, target: UIView, top: Float?, left: Float?, right: Float?, bottom: Float?, height: Float?, width: Float?, centerY: Bool, centerX: Bool) {
        
        target.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(target)
        
        var verticalFormat = "V:"
        if let top = top {
            verticalFormat += "|-(\(top))-"
        }
        verticalFormat += "[target"
        if let height = height {
            verticalFormat += "(\(height))"
        }
        verticalFormat += "]"
        if let bottom = bottom {
            verticalFormat += "-(\(bottom))-|"
        }
        let verticalConstrains = NSLayoutConstraint.constraints(withVisualFormat: verticalFormat, options: [], metrics: nil, views: [ "target" : target ])
        superview.addConstraints(verticalConstrains)
        
        var horizonFormat = "H:"
        if let left = left {
            horizonFormat += "|-(\(left))-"
        }
        horizonFormat += "[target"
        if let width = width {
            horizonFormat += "(\(width))"
        }
        horizonFormat += "]"
        if let right = right {
            horizonFormat += "-(\(right))-|"
        }
        let horizonConstrains = NSLayoutConstraint.constraints(withVisualFormat: horizonFormat, options: [], metrics: nil, views: [ "target" : target ])
        superview.addConstraints(horizonConstrains)
        
        if centerX {
            let centerXConstraint = NSLayoutConstraint(item: superview, attribute: .centerX, relatedBy: .equal, toItem: target, attribute: .centerX, multiplier: 1.0, constant: 0)
            superview.addConstraint(centerXConstraint)
        }
        
        if centerY {
            let centerXConstraint = NSLayoutConstraint(item: superview, attribute: .centerY, relatedBy: .equal, toItem: target, attribute: .centerY, multiplier: 1.0, constant: 0)
            superview.addConstraint(centerXConstraint)
        }
    }
}
