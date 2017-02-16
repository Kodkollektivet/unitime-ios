//
//  LnuOval.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/6/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit

class LnuOval: UIView {
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(isBig: Bool) {
        if isBig {
            self.init(frame: CGRect(x: 0, y: 0, width: 19, height: 19))
        } else {
            self.init(frame: CGRect(x: 0, y: 0, width: 11, height: 11))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //19 19  -  11 11
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.bounds.size.height/2
        self.backgroundColor = UIColor.black
        
        self.clipsToBounds = true
    }
    
}
