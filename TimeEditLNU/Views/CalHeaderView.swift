//
//  CalHeaderView.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 1/9/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CalHeaderView: JTAppleHeaderView {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var monthLabel: UILabel!
    
    // ========================================
    // MARK: - IBActions
    // ========================================
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        
    }
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    var monthString: String? {
        didSet{
            monthLabel.text = monthString
        }
    }
}
