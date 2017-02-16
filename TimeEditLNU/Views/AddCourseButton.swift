//
//  AddCourseButton.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/13/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit

class AddCourseButton: UIButton {
    
    let kAdded = 1
    let kNotAdded = 0
    
    let addGreenColor = UIColor(red: 157/255, green: 219/255, blue: 145/255, alpha: 1.0)
    let removeRedColor = UIColor(red: 219/255, green: 145/255, blue: 145/255, alpha: 1.0)
    
    var toggleState = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    func setupButton(isAdded: Bool){
        
        [UIView .animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions() , animations: { () -> Void in

            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        }, completion: { (finished) -> Void in
            
            if isAdded {
                let font = UIFont(name: "HelveticaNeue", size: 18.0)!
                
                let attributedText = NSAttributedString(string: "Remove", attributes: [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white])
                self.setAttributedTitle(attributedText, for: UIControlState.normal)
                
                self.layer.cornerRadius = 5.0
                self.clipsToBounds = true
                
                self.setBackgroundImage(UIImage.imageWithColor(color: self.removeRedColor, size: CGSize(width: 100, height: 100)), for: UIControlState.normal)
                
                self.sizeToFit()
                
                self.toggleState = self.kAdded
                
            } else {
                let font = UIFont(name: "HelveticaNeue", size: 18.0)!
                
                let attributedText = NSAttributedString(string: "Add", attributes: [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.white])
                self.setAttributedTitle(attributedText, for: UIControlState.normal)
                
                self.layer.cornerRadius = 5.0
                self.clipsToBounds = true
                
                self.setBackgroundImage(UIImage.imageWithColor(color: self.addGreenColor, size: CGSize(width: 100, height: 100)), for: UIControlState.normal)
                
                self.sizeToFit()
                
                self.toggleState = self.kNotAdded
            }

            

            [UIView .animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: UIViewAnimationOptions() , animations: { () -> Void in

                self.transform = CGAffineTransform(scaleX: 1, y: 1)

            }, completion: { (finished) -> Void in

                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            })]
            
        })]
        
        
    }
    
    func toggle(){
        
//        self.setupButton(isAdded: toggleState)
        
//        if self.toggleState == self.kNotAdded {
//            self.setupButton(isAdded: self.kAdded)
//            self.toggleState = self.kAdded
//            print("REMOVE SHOULD BE THERE")
//            
//        } else {
//            self.setupButton(isAdded: self.kNotAdded)
//            self.toggleState = self.kNotAdded
//            print("ADD SHOULD BE THERE")
//        }
        


    }
    
}
