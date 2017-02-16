//
//  UINib+Extension.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 1/26/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func getClassName() -> String {
        let fullClassString = NSStringFromClass(self.classForCoder)
        return fullClassString.components(separatedBy: ".").last!
    }
    
}



extension UINib {
    
    class func getNibNameFromClass(_ aClass: AnyClass!) -> String! {
        let fullClassString = NSStringFromClass(aClass)
        
        return fullClassString.components(separatedBy: ".").last!
    }
}
