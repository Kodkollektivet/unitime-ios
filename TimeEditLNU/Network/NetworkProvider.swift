//
//  NetworkProvider.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 2/1/17.
//  Copyright © 2017 Alper Gündogdu. All rights reserved.
//

import UIKit
import Moya
import Alamofire


// ========================================
// MARK: EXTENSIONS
// ========================================

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

// ========================================
// MARK: FIELD CONSTANTS
// ========================================

let BASE_URL = "https://api.kodkollektivet.se/unitime/"

// ========================================
// MARK: - Public properties
// ========================================

let networkProvider = MoyaProvider(endpointClosure: endpointsClosure)

//let networkProvider = MoyaProvider(endpointClosure: endpoints

let endpointsClosure = { (target: NetworkProvider) -> Endpoint<NetworkProvider> in
    var endpoint = Endpoint<NetworkProvider>(
        url: target.baseURL.appendingPathComponent(target.path).absoluteString,
        sampleResponseClosure: {.networkResponse(200, target.sampleData as Data)},
        method: target.method,
        parameters: target.parameters
        //        parameterEncoding: .URL
    )
    
//    if !InternetConnection.connectedToNetwork() {
//        ShowBanner("NO_INTERNET")
//    }
//    
//    let currentUser: User?
//    var production = false
    
    return endpoint
//    switch target {
//        
//        //            case .register:
//        //                return endpoint.endpointByAddingHTTPHeaderFields(["DeviceToken": String(describing: target.parameters!["deviceToken"]) ])
//        //            case .login:
//        //                return endpoint.endpointByAddingHTTPHeaderFields(["DeviceToken": String(describing: target.parameters!["deviceToken"]) ])
//    //TODO: add all the cases here
//    default:
//        
//        if let deviceToken = getDeviceToken() {
//            
//            var dict = ["DeviceToken": deviceToken, "Developer": CONFIG_MODEL.isProduct ? "0" : "1", "Platform": CONFIG_MODEL.platform]
//            if let token = getToken() {
//                dict.updateValue(token, forKey: "Authorization")
//                
//            }
//            return endpoint.endpointByAddingHTTPHeaderFields(dict)
//        } else {
//            var dict = ["DeviceToken": "SimulatorToken", "Developer": CONFIG_MODEL.isProduct ? "0": "1", "Platform": CONFIG_MODEL.platform]
//            if let token = getToken() {
//                dict.updateValue(token, forKey: "Authorization")
//                
//            }
//            return endpoint.endpointByAddingHTTPHeaderFields(dict)
//        }
//        
//    }
    
}


// ========================================
// MARK: Main
// ========================================

enum NetworkProvider {
    
    case getCoursesEvents(courses: [String])
    
    case getCourseCodes()
    
    case getCourses()
    
}


extension NetworkProvider: TargetType {
    
    
    var baseURL:URL {
        
        return URL(string: BASE_URL)!
    }
    
    var path:String{
        
        switch self{
        
        case .getCoursesEvents:
            return "event/"
            
        case .getCourseCodes():
            return "codes/"
            
        case .getCourses():
            return "course/"
            
        default:
            return ""
            
        }
    }
    
    
    var method:Moya.Method{
        
        switch self{
        //Only write the .GET methods explicitly
        case .getCoursesEvents:
            return .post
            
            
        default :
            return .get
            
        }
        
    }
    
    public var parameters: [String : Any]? {
        switch self
        {
            
        case .getCoursesEvents(let courses):
            return ["courses": courses.joined(separator: ",")]
            
            
        default:
            return [:]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return Alamofire.ParameterEncoding as! ParameterEncoding
    }
    
    
    var sampleData:Data
    {
        return Data()
    }
    
    public var task: Task {
        
        switch self {
//        case .editProfile(_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, let photo):
//            return .upload(.multipart([MultipartFormData(provider: .data(photo), name: "profile_img", fileName: "image.jpg", mimeType: "image/jpeg")]))
//        case .register(_, _, _, _, let photo):
//            
//            if let photo = photo {
//                return .upload(.multipart([MultipartFormData(provider: .data(photo), name: "profile_img", fileName: "image.jpg", mimeType: "image/jpeg")]))
//            }
        default:
            break
            
        }
        return .request
    }
    
    var validate: Bool {
        return false
    }
}






