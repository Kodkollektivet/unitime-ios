//
//  CourseDetailCell.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/8/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import UIKit

protocol CourseDetailCellProtocol: class {
    func urlBtnClicked(url: String?)
    func addBtnClicked(section: Int)
}

class CourseDetailCell: UITableViewCell {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var locationLabel: DetailLabel!
    @IBOutlet fileprivate weak var termLabel: DetailLabel!
    @IBOutlet fileprivate weak var creditLabel: DetailLabel!
    @IBOutlet fileprivate weak var speedLabel: DetailLabel!
    @IBOutlet fileprivate weak var languageLabel: DetailLabel!
    @IBOutlet fileprivate weak var urlButton: UIButton!
    @IBOutlet fileprivate weak var syllabusButton: UIButton!
    
    @IBOutlet weak var addCourseBtn: AddCourseButton!
    
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    var section: Int!
    
    var courseCode: String!
    
    var locationString: String? {
        didSet{
            locationLabel.setupLabel(str: locationString)
        }
    }
    
    var termString: String? {
        didSet{
            termLabel.setupLabel(str: termString)
        }
    }
    
    var creditsString: String? {
        didSet{
            creditLabel.setupLabel(str: creditsString)
        }
    }
    
    var speedString: String? {
        didSet{
            speedLabel.setupLabel(str: speedString)
        }
    }
    
    var languageString: String? {
        didSet{
            languageLabel.setupLabel(str: languageString)
        }
    }
    
    var urlString: String? {
        didSet{
            urlButton.contentHorizontalAlignment = .left
            urlButton.setTitle(urlString, for: UIControlState.normal)
            
        }
    }
    
    var syllabusString: String? {
        didSet{
            syllabusButton.contentHorizontalAlignment = .left
            syllabusButton.setTitle(syllabusString, for: UIControlState.normal)
        }
    }

    
    class var reuseIdentifier: String {
        return "CourseDetailCellReuseIdentifier"
    }
    
    class var nib: UINib {
        
        return UINib(nibName: UINib.getNibNameFromClass(CourseDetailCell.self), bundle: nil)
    }
    
    var delegate: CourseDetailCellProtocol?
    
    
    // ========================================
    // MARK: - IBAction
    // ========================================
    
    @IBAction func urlButtonClicked(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.urlBtnClicked(url: sender.title(for: UIControlState.normal))
        }
    }
    
    //A tiny violation MVC here we modify userdefaults 
    @IBAction func addBtnClicked(_ sender: AddCourseButton) {
        if addCourseBtn.toggleState == addCourseBtn.kAdded {
            removeCourse(courseCode: courseCode)
        } else {
            addCourse(courseCode: courseCode)
        }
        
        
        if let delegate = delegate {
            delegate.addBtnClicked(section: section)
        }
        
    }
    
    // ========================================
    // MARK: - Public functions
    // ========================================
    
//    func toggleAddBtn(isAdded: Bool){
//        
//        addCourseBtn.toggle()
//        
//    }
    
    
    
}
