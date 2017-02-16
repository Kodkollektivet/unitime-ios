//
//  LoadingAnimView.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/16/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import UIKit

class LoadingAnimView: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        initializeAnimation()
    }
    
    func initializeAnimation(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(blurView)
        blurView.frame = self.frame
        
        
        self.alpha = 0
        let aniView = LnuLogoAniView(frame: CGRect(x: 0, y: 0, width: 150, height: 182))
        self.addSubview(aniView)
        NSLayoutConstraint.applyAutoLayout(superview: self, target: aniView, top: nil, left: nil, right: nil, bottom: nil, height: 182, width: 150, centerY: true, centerX: true)
        aniView.startAnimating()
        
        
        let loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        loadingLabel.text = "Loading..."
        let font = UIFont(name: "HelveticaNeue-bold", size: 18.0)!
        loadingLabel.attributedText = NSAttributedString(string: "Loading...", attributes: [NSForegroundColorAttributeName: UIColor.darkGray, NSFontAttributeName: font])
        loadingLabel.textAlignment = NSTextAlignment.center
        loadingLabel.sizeToFit()
        
        self.addSubview(loadingLabel)
        NSLayoutConstraint.applyAutoLayout(superview: self, target: loadingLabel, top: nil, left: nil, right: nil, bottom: 100, height: nil, width: nil, centerY: false, centerX: true)

    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superV = self.superview {
            NSLayoutConstraint.applyAutoLayout(superview: superV, target: self, top: 0, left: 0, right: 0, bottom: 0, height: nil, width: nil, centerY: false, centerX: false)
            
        }
    }
    
    func startAnimating(){
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }) { (Bool) in
            
        }

    }
    
    func stopAnimating(){
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }, completion: { (Bool) in
            if let superV = self.superview {
                self.removeFromSuperview()
            }
        })
    }
    
}
