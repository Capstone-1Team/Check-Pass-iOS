//
//  User.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Foundation

struct User {
    var USER_NUMBER: String    //Student Id or Professor Id
    var LECTURES: [String]
    var PROFILE_IMAGE: String
    var USER_NAME: String
    var USER_TYPE: UserType
    var DEPARTMENT: [String]
}

enum UserType: String {
    case student = "STUDENT"
    case professor = "PROFESSOR"
    case staff = "STAFF"
    case unknown = "UNKNOWN"
    
    static var userTypeList: [String] {
        ["구분을 선택해주세요", "학생", "교수", "교직원"]
    }
}
