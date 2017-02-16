//
//  CourseCell.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/4/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import UIKit
import LUExpandableTableView

class CourseCell: LUExpandableTableViewSectionHeader {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var courseNameLabel: UILabel! {
        didSet{
            courseNameLabel.text = ""
        }
    }
    
    @IBOutlet fileprivate weak var courseNoteLabel: UILabel! {
        didSet{
            courseNoteLabel.text = ""
        }
    }
    
    @IBOutlet fileprivate weak var addIndicator: UIImageView! {
        didSet{
            addIndicator.isHidden = false
        }
    }
    
    @IBOutlet weak var moreButton: UIButton!{
        didSet{
            moreButton.contentHorizontalAlignment = .right
        }
    }
    // ========================================
    // MARK: - IBActions
    // ========================================
    
    @IBAction func optionsBtnClicked(_ sender: UIButton) {

         delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
        
    }
    
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    //var delegate: CourseCellDelegate?
    
    var courseNameString: String? {
        didSet{
            courseNameLabel.text = courseNameString
        }
    }
    
    var courseNoteString: String? {
        didSet{
            courseNoteLabel.text = courseNoteString
        }
    }
    
    var courseModel: CourseModel? {
        didSet{
            
        }
    }
    
    class var reuseIdentifier: String {
        return "CourseCellReuseIdentifier"
    }
    
    class var nib: UINib {
        
        return UINib(nibName: UINib.getNibNameFromClass(CourseCell.self), bundle: nil)
    }
    
    var isAdded: Bool? {
        didSet{
            self.addIndicator.alpha = (self.isAdded! == true ? 1.0 : 0.0)
//            if isAdded! {
//                UIView.animate(withDuration: 1, animations: { 
//                    self.addIndicator.alpha = (self.isAdded! == true ? 1.0 : 0.0)
//                })
//            }
        }
    }
    
    // ========================================
    // MARK: - Private properties
    // ========================================
    
    
    
    
}
