//
//  Lecture.swift
//  CheckPass
//
//  Created by 이정훈 on 10/1/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Lecture: Codable, Identifiable {
    @DocumentID var id: String?
    var ATTENDANCE_STATUS: Int    //출석 현황
    var BEACON_MAJOR: Int    //beacon major value
    var BEACON_MINOR: Int    //beacon minor value
    var BEACON_UUID: String    //beacon UUID
    var DETAILS: String
    var LECTURE_NAME: String    //강의명
    var LECTURE_ROOM: String    //강의실
    var PROFESSOR_NAME: String    //교수명
    var TOTAL_USER: Int    //수강 중인 총원
    var LECTURE_TIME1: [String]
    var LECTURE_TIME2: [String]
}
