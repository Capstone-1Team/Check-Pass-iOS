//
//  EAttendanceInfo.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Foundation
import FirebaseFirestore

struct EAttendanceInfo: Codable, Equatable {
    var END_STAMP: Timestamp
    var START_STAMP: Timestamp
    var RANDOM_CODE: String
}
