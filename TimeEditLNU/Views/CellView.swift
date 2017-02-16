//
//  CellView.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 1/9/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CellView: JTAppleDayCellView {
    
    // ========================================
    // MARK: - IBInspectables
    // ========================================
    
    @IBInspectable var inactiveColor: UIColor!
    @IBInspectable var normalColor: UIColor!
    //@IBInspectable var lnuYellowColor: UIColor!
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var selectedView: AnimationView! {
        didSet{
            selectedView.layer.cornerRadius = selectedView.bounds.height/2
            selectedView.backgroundColor = inactiveColor
            selectedView.clipsToBounds = false
        }
    }
    
    @IBOutlet fileprivate weak var dayLabel: UILabel!
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    var dayString: String? {
        didSet{
            dayLabel.text = dayString
        }
    }
    
    lazy var cal: DateFormatter = {
        let fmtter = DateFormatter()
        fmtter.dateFormat = "yyyy-MM-dd"
        return fmtter
    }()
    
    lazy var todayDate: String = {
        [weak self] in
        let aString = self!.cal.string(from: Date())
        return aString
        }()


    // ========================================
    // MARK: - Private properties
    // ========================================
    
    fileprivate let kTodayLabelTag = 111
    
    // ========================================
    // MARK: - Public functions
    // ========================================
    
    func configureVisibility(_ cellState: CellState) {
        if
            cellState.dateBelongsTo == .thisMonth ||
                cellState.dateBelongsTo == .previousMonthWithinBoundary ||
                cellState.dateBelongsTo == .followingMonthWithinBoundary {
            self.isHidden = false
        } else {
            self.isHidden = false
            
        }
    }
    
    func configureTextColor(_ cellState: CellState) {
        if dayLabel.tag == kTodayLabelTag {
            //Do nothing
        
        } else {
            //if cellState.isSelected {
                //dayLabel.textColor = UIColor.brown
            if cellState.dateBelongsTo == .thisMonth {
                dayLabel.textColor = normalColor
            } else {
                dayLabel.textColor = inactiveColor
                print("OTHER: \(dayLabel.text)")
            }
        }
    }
    
    func cellSelectionChanged(_ cellState: CellState) {
        if cellState.isSelected == true {
            if selectedView.isHidden == true {
                configueViewIntoBubbleView(cellState)
                selectedView.animateWithBounceEffect(withCompletionHandler: {
                })
            }
        } else {
            configueViewIntoBubbleView(cellState, animateDeselection: true)
        }
    }
    
    func setupCellBeforeDisplay(_ cellState: CellState, date: Date) {
    
        if cal.string(from: date) == todayDate {
            dayLabel.tag = kTodayLabelTag
//            let shadow = NSShadow()
//            shadow.shadowBlurRadius = 1.0
//            shadow.shadowOffset = CGSize(width: 0, height: 0)
//            shadow.shadowColor = UIColor.black
            
            let font = UIFont(name: "HelveticaNeue-bold", size: 17)!
            
            self.dayLabel.attributedText = NSAttributedString(string: cellState.text, attributes: [NSForegroundColorAttributeName: normalColor, NSFontAttributeName: font])
            
        } else {
            dayLabel.text =  cellState.text
            configureTextColor(cellState)
        }
        
        
        
        // Setup text color
        
        // Setup Cell Background color
//        self.backgroundColor = cal.string(from: date) == todayDate ? lnuYellowColor: normalColor
//        self.layer.cornerRadius = 10.0
        
        
        // Setup cell selection status
        //        delayRunOnMainThread(0.0) {
        self.configueViewIntoBubbleView(cellState)
        //        }
        // Configure Visibility
        configureVisibility(cellState)
    }
    
    fileprivate func configueViewIntoBubbleView(_ cellState: CellState, animateDeselection: Bool = false) {
        if cellState.isSelected {
            self.selectedView.isHidden = false
            configureTextColor(cellState)
        } else {
            if animateDeselection {
                configureTextColor(cellState)
                if selectedView.isHidden == false {
                    //                    selectedView.animateWithFadeEffect(withCompletionHandler: { () -> Void in
                    self.selectedView.isHidden = true
                    //                        self.selectedView.alpha = 1
                    //                    })
                }
            } else {
                selectedView.isHidden = true
            }
        }
    }
}



class AnimationView: UIView {
    func animateWithFlipEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        AnimationClass.flipAnimation(self, completion: completionHandler)
    }
    func animateWithBounceEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        let viewAnimation = AnimationClass.BounceEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
    func animateWithFadeEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        let viewAnimation = AnimationClass.fadeOutEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}
