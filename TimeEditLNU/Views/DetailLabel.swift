//
//  DetailLabel.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/13/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit

class DetailLabel: UILabel {
    
    let topInset = CGFloat(5)
    let bottomInset = CGFloat(5)
    let leftInset = CGFloat(10)
    let rightInset = CGFloat(10)
    
    override func drawText(in rect: CGRect)
    {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize
    {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
    func setupLabel(str: String?){
        let font = UIFont(name: "HelveticaNeue", size: 18.0)!
        self.attributedText = NSAttributedString(string: str!, attributes: [NSFontAttributeName: font])
        self.textAlignment = NSTextAlignment.center
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        
        self.backgroundColor = UIColor.darkGray
        self.textColor = UIColor.white
        self.sizeToFit()

    }
    
}
