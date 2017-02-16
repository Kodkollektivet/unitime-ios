//
//  AddCourseOps.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/13/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

let kAddedCourses = "kAddedCourses"

import Foundation

func addCourse(courseCode: String){

    if var coursesArr = getCourseArr() {
        coursesArr.append(courseCode)
        UserDefaults().set(coursesArr, forKey: kAddedCourses)
    }
    
}

func removeCourse(courseCode: String){

    if var coursesArr = getCourseArr() {
        var i = 0
        for code in coursesArr {
            if code == courseCode {
                coursesArr.remove(at: i)
            }
            i += 1
        }
        UserDefaults().set(coursesArr, forKey: kAddedCourses)
    }
    
}

func numberOfMyCourses() -> Int {
    if let courses = getCourseArr() {
        return courses.count
    } else {
        return 0
    }
    
}

func getMyCourses() -> [String] {
    if let courses = getCourseArr() {
        return courses
    }
    
    return [String]()
    
    
}

func isCourseAdded(courseCode: String) -> Bool {
    
    if let coursesArr = getCourseArr() {
        return coursesArr.contains(courseCode)
    }
    
    return false
    
}

func getCourseArr() -> [String]? {
    return UserDefaults().value(forKey: kAddedCourses) as? [String]

}

func initCourses(){
    let userDef = UserDefaults()
    if userDef.object(forKey: kAddedCourses) == nil {
        userDef.set([String](), forKey: kAddedCourses)
    }
}
