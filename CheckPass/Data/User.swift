//
//  User.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Foundation

struct User: Identifiable {
    var id: String
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
}
