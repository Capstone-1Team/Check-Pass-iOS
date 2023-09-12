//
//  User.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Foundation

struct User: Identifiable {
    var id: String    //Student Id or Professor Id
    var LACTURES: [String]
    var PROFILE_IMAGE: String
    var USER_NAME: String
    var USER_TYPE: UserType
}

enum UserType: String {
    case student = "STUDENT"
    case professor = "PROFESSOR"
    case staff = "STAFF"
    case unkown = "UNKOWN"
    
    static var userTypeList: [String] {
        ["학생", "교수", "교직원"]
    }
}
