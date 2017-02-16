//
//  EventModel.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/3/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import Foundation
import ObjectMapper

class EventModel: NSObject, Mappable {
    
    var startDate: String?
    var startTime: String?
    var endTime: String?
    var info: String?
    var room: String?
    var teacher: String?
    var desc: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        startDate <- map["startdate"]
        startTime <- map["starttime"]
        endTime <- map["endtime"]
        info <- map["info"]
        room <- map["room"]
        teacher <- map["teacher"]
        desc <- map["desc"]
        
    }
    
}
