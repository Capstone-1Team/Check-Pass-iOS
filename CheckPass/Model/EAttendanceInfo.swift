//
//  ElectronicAttendanceInfo.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Foundation

struct ElectronicAttendanceInfo: Codable {
    var END_STAMP: Date
    var START_STAMP: Date
    var RANDOM_CODE: String
}
