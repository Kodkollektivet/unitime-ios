//
//  LnuLogoAniView.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/7/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit

class LnuLogoAniView: UIView {
    
    // ========================================
    // MARK: - View Init
    // ========================================
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        placeOvals()
        //initializeSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        placeOvals()
        //initializeSubviews()
    }

    var ovals: [LnuOval]!
    var ovalCoordinates: [(Float, Float)]!
    
    //topView container view
    //fileprivate var container: UIView!
    
    func placeOvals() {
        
        let oval2 = LnuOval(isBig: false)
        let oval4 = LnuOval(isBig: true)
        let oval5 = LnuOval(isBig: true)
        let oval6 = LnuOval(isBig: true)
        let oval7 = LnuOval(isBig: true)
        let oval8 = LnuOval(isBig: true)
        let oval9 = LnuOval(isBig: true)
        let oval10 = LnuOval(isBig: true)
        let oval11 = LnuOval(isBig: true)
        let oval12 = LnuOval(isBig: true)
        let oval13 = LnuOval(isBig: true)
        let oval14 = LnuOval(isBig: true)
        let oval15 = LnuOval(isBig: true)
        let oval16 = LnuOval(isBig: false)
        let oval3 = LnuOval(isBig: false)
        let oval17 = LnuOval(isBig: false)
        let oval = LnuOval(isBig: true)
        
        ovals = [oval2, oval4, oval5, oval6, oval7, oval8, oval9, oval10, oval11, oval12, oval13, oval14, oval15, oval16, oval3, oval17, oval]
        
        ovalCoordinates = [(47, 36), (79, 29), (62, 40), (93, 44), (75, 58), (96, 67), (41, 59), (78, 80), (98, 92), (79, 104), (44, 102), (48, 81), (27, 85), (30, 71), (66, 26), (114, 83), (25, 41) ]
        
        var i = 0
        for oval in ovals {
            self.addSubview(oval)
            NSLayoutConstraint.applyAutoLayout(superview: self, target: oval, top: ovalCoordinates[i].1, left: ovalCoordinates[i].0, right: nil, bottom: nil, height: Float(oval.bounds.height), width: Float(oval.bounds.width), centerY: false, centerX: false)
            i += 1
        }
        
        let branchView = LnuBranchView(frame: CGRect(x: 0, y: 0, width: 36, height: 107.5))
        self.addSubview(branchView)
        
        NSLayoutConstraint.applyAutoLayout(superview: self, target: branchView, top: 50.5, left: 43, right: nil, bottom: nil, height: Float(branchView.bounds.size.height), width: Float(branchView.bounds.size.width), centerY: false, centerX: false)
        
        branchView.backgroundColor = UIColor.clear
        branchView.tintColor = UIColor.clear
        
    }
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    
    func addGravityAnimation() {
        
        animator = UIDynamicAnimator(referenceView: self)
        
        gravity = UIGravityBehavior(items: self.ovals)
        gravity.gravityDirection = CGVector(dx: -gravity.gravityDirection.dx, dy: -gravity.gravityDirection.dy)
        animator.addBehavior(gravity)
        
        //collision = UICollisionBehavior(items: ovals)
        
        
        for oval in self.ovals {
            
            collision = UICollisionBehavior(items: [oval])
            collision.addBoundary(withIdentifier: "selfFrame" as NSCopying, for: UIBezierPath(rect: self.bounds))
            animator.addBehavior(collision)
            
        }
        
        elasticity = UIDynamicItemBehavior(items: self.ovals)
        elasticity.elasticity = 0.2
        animator.addBehavior(elasticity)
        

        
    }
    
    var timer: Timer!
    var isAnimating = false
    func startAnimating() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(LnuLogoAniView.myPerformCode(timer:)), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    
    func myPerformCode(timer : Timer) {
        
        DispatchQueue.main.async {
            if !self.isAnimating {
                self.animate()
            }
        }
        
    }

    
    
    func animate() {
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }) { (Bool) in
            
            self.addGravityAnimation()
            self.perform(#selector(LnuLogoAniView.animateBack), with: nil, afterDelay: 1)
            
        }
        
        
        
        
    }
    
    func animateBack() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.transform = CGAffineTransform(rotationAngle: CGFloat(2 * M_PI))
        }) { (Bool) in
            self.animateBackOvals()
        }
    }
    
    func animateBackOvals(){
        UIView.animate(withDuration: 0.8) {
            var i = 0
            for oval in self.ovals {
                oval.frame.origin.y = CGFloat(self.ovalCoordinates[i].1)
                i += 1
            }
        }
    }

    
}

