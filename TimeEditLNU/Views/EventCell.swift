//
//  EventCell.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 1/12/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import UIKit


class EventCell: UITableViewCell {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var fromTimeLabel: UILabel!
    @IBOutlet fileprivate weak var endTimeLabel: UILabel!
    @IBOutlet fileprivate weak var eventNameLabel: UILabel!
    @IBOutlet fileprivate weak var eventNoteLabel: UILabel!
    
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    var fromTimeString: String? {
        didSet{
            fromTimeLabel.text = fromTimeString
        }
    }
    
    var endTimeString: String? {
        didSet{
            endTimeLabel.text = endTimeString
        }
    }
    
    var eventNameString: String? {
        didSet{
            eventNameLabel.text = eventNameString
        }
    }
    
    var eventNoteString: String? {
        didSet{
            eventNoteLabel.text = eventNoteString
        }
    }

    class var reuseIdentifier: String {
        return "EventCellReuseIdentifier"
    }
    
    class var nib: UINib {
        
        return UINib(nibName: UINib.getNibNameFromClass(EventCell.self), bundle: nil)
    }
    
    // ========================================
    // MARK: - Private properties
    // ========================================
    
    

    
}
