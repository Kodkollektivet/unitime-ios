//
//  AddCoursesPopupVC.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/3/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import LUExpandableTableView

protocol AddCoursesPopupVCDelegate: class {
    func popupDismissed()
}

class AddCoursesPopupVC: UIViewController, LUExpandableTableViewDataSource, LUExpandableTableViewDelegate, UISearchBarDelegate, CourseDetailCellProtocol {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet fileprivate weak var searchbar: UISearchBar!
    @IBOutlet fileprivate weak var tableView: LUExpandableTableView!
    
    // ========================================
    // MARK: - Private properties
    // ========================================
    
    fileprivate let kCoursecodes = "kCourseCodes"
    fileprivate var courses: [CourseModel] = [CourseModel]()
    fileprivate var filteredCourses = [CourseModel]()
    fileprivate var myCourses = [CourseModel]()
    
    fileprivate let kSearchIndex = 0
    fileprivate let kMyCoursesIndex = 1
    fileprivate var currentSegementIndex = 0
    
    let aniContainer = LoadingAnimView()
    
    // ========================================
    // MARK: - Public properties
    // ========================================
    
    var delegate: AddCoursesPopupVCDelegate?
    
    // ========================================
    // MARK: - IBActions
    // ========================================
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == kSearchIndex {
            currentSegementIndex = kSearchIndex
            
            UIView.animate(withDuration: 0.2, animations: { 
                self.searchbar.alpha = 1.0
            })
            
            tableView.reloadData()
            
            
        } else {
            currentSegementIndex = kMyCoursesIndex
            
            UIView.animate(withDuration: 0.2, animations: {
                self.searchbar.alpha = 0.0
            })
            
            setupMyCourses()
            
//            tableView.beginUpdates()
//            tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.none)
//            tableView.should
            tableView.reloadData()
            
            
        }
    }
    
    
    // ========================================
    // MARK: - VC lifecycle
    // ========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchbar()
        getCoursesEvents()
        
        self.view.addSubview(aniContainer)
        aniContainer.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let delegate = delegate {
            delegate.popupDismissed()
        }
    }
    
    
}

// ========================================
// MARK: - Private functions
// ========================================

fileprivate extension AddCoursesPopupVC {
    
    func setupTableView() {
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 207
        tableView.estimatedSectionHeaderHeight = 120
        tableView.estimatedSectionFooterHeight = 0
        tableView.expandableTableViewDelegate = self
        tableView.expandableTableViewDataSource = self
        tableView.register(CourseDetailCell.nib, forCellReuseIdentifier: CourseDetailCell.reuseIdentifier)
        tableView.register(CourseCell.nib, forHeaderFooterViewReuseIdentifier: CourseCell.reuseIdentifier)
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        tableView.allowsSelection = false
    }
    
    func setupSearchbar(){
        searchbar.delegate = self
        
    }
    
    func searchEachArray(searchText: String) {
        
        var index = 0
        for course in courses {
            
            if course.nameSv!.contains(searchText) || course.nameEn!.contains(searchText) || course.courseCode!.contains(searchText) {
                filteredCourses.append(course)
            }
            index += 1
        }
        
    }
    
    func setupMyCourses(){
        myCourses.removeAll()
        
        for courseCode in getMyCourses() {
            for course in courses {
                if course.courseCode == courseCode {
                    myCourses.append(course)
                    break
                }
            }
        }
        
    }

    
}

// ========================================
// MARK: - UISearchBarDelegate
// ========================================

extension AddCoursesPopupVC {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCourses.removeAll()
        tableView.clearsContextBeforeDrawing = true
        searchEachArray(searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
    }
    
}




// ========================================
// MARK: - LUExpandableTableViewDataSource
// ========================================

extension AddCoursesPopupVC {
    
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        if currentSegementIndex == kMyCoursesIndex {
            return myCourses.count
        } else if searchbar.text!.characters.count > 0 {
            return filteredCourses.count
        }
        return courses.count
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: CourseDetailCell.reuseIdentifier) as? CourseDetailCell else {
            //assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        let course: CourseModel
        if currentSegementIndex == kMyCoursesIndex {
            course = myCourses[indexPath.section]
        } else {
            course = (searchbar.text!.characters.count > 0) ? filteredCourses[indexPath.section] : courses[indexPath.section]
        }
        
        
        
        cell.delegate = self
        cell.section = indexPath.section
        cell.courseCode = course.courseCode!
        
        cell.locationString = course.courseLocation
        cell.termString = course.semester
        cell.creditsString = course.coursePoints
        cell.speedString = course.courseSpeed
        cell.languageString = course.courseLanguage
        cell.urlString = course.url
        cell.syllabusString = course.syllabusEn
        
        cell.addCourseBtn.setupButton(isAdded: isCourseAdded(courseCode: course.courseCode!))
        
        return cell
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: CourseCell.reuseIdentifier) as? CourseCell else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }

        let course: CourseModel
        if currentSegementIndex == kMyCoursesIndex {
            course = myCourses[section]
        } else {
            course = (searchbar.text!.characters.count > 0) ? filteredCourses[section] : courses[section]
        }


        sectionHeader.courseNameString = course.courseCode
        sectionHeader.courseNoteString = course.nameEn

        sectionHeader.isAdded = isCourseAdded(courseCode: course.courseCode!)
        
        
        return sectionHeader
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        
        
    }

    
}

// ========================================
// MARK: - LUExpandableTableViewDelegate
// ========================================

extension AddCoursesPopupVC {
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 207
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 120
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        //print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        //print("Did select cection header at section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
//        //print("Will display section header for section \(section)")
//    }

    
}

// ========================================
// MARK: - CourseDetailCellProtocol
// ========================================

extension AddCoursesPopupVC {
    
    func linkClicked(url: String) {
        
        let alertView = UIAlertController(title: "Would you like to open this link in an external browser?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let actionOpenUrl = UIAlertAction(title: "Open", style: UIAlertActionStyle.default) { (action) in
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        
        alertView.addAction(actionOpenUrl)
        alertView.addAction(actionCancel)
        
        self.present(alertView, animated: true, completion: nil)
        alertView.view.tintColor = UIColor.black
    }
    
    func urlBtnClicked(url: String?) {
        if let url = url {
            linkClicked(url: url)
        }
    }
    
    func addBtnClicked(section: Int) {
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: UITableViewRowAnimation.none)
        tableView.endUpdates()
    }
    
}


// ========================================
// MARK: - Network Ops
// ========================================

extension AddCoursesPopupVC {
    
    func getCoursesEvents(){
        
        let userdefaults = UserDefaults()
        
        if let courses = userdefaults.value(forKey: kCoursecodes) {
            self.courses = courses as! [CourseModel]
            tableView.reloadData()
            
        } else {
        
            networkProvider.request(NetworkProvider.getCourses(), completion: { (result) -> () in
                
                switch result{
                    
                case let .success(result):
                    
                    do
                    {
                        let resultString = try result.mapString()
                        let resultJSON = JSON(data: resultString.data(using: String.Encoding.utf8)!)
                        
                        var i = 0
                        for _ in resultJSON {
                            let course = Mapper<CourseModel>().map(JSONString: resultJSON[i].rawString()!)
                            self.courses.append(course!)
                            i += 1
                        }
                        
                        //userdefaults.set(self.courses, forKey: self.kCoursecodes)
                        //self.courses = courses!.courseCodes!
                        self.tableView.reloadData()
                        
                        self.aniContainer.stopAnimating()
                        
                    }
                    catch
                    {
                        
                    }
                    
                    
                case let .failure(error):
                    print(error)
                }
                
            })
        }
        
    }
    
    
}

