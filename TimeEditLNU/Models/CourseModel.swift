//
//  CourseModel.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/4/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import ObjectMapper

class CourseModel: NSObject, Mappable {
    
    var nameEn: String?
    var nameSv: String?
    var syllabusSv: String?
    var syllabusEn: String?
    var courseCode: String?
    var courseId: String?
    var courseReg: String?
    var coursePoints: String?
    var courseLocation: String?
    var courseLanguage: String?
    var courseSpeed: String?
    var semester: String?
    var url: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nameEn <- map["name_en"]
        nameSv <- map["name_sv"]
        syllabusSv <- map["syllabus_sv"]
        syllabusEn <- map["syllabus_en"]
        courseCode <- map["course_code"]
        courseId <- map["course_id"]
        courseReg <- map["course_reg"]
        coursePoints <- map["course_points"]
        courseLocation <- map["course_location"]
        courseLanguage <- map["course_language"]
        courseSpeed <- map["course_speed"]
        semester <- map["semester"]
        url <- map["url"]
    }
    
}
