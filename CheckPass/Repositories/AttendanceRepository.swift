//
//  AttendanceRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 10/20/23.
//

import Combine
import FirebaseDatabase
import FirebaseAuth

struct AttendanceRepository {
    static let ref: DatabaseReference! = Database.database(url: realtimeDatbaseURL).reference()
    
    static func setAttendanceData(for lectureId: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            ref.child("Attendance")
               .child(lectureId)
               .child(Auth.auth().currentUser?.uid ?? "")
               .child("0")
               .setValue(true) { (error, _) in
                   guard error == nil else {
                       promise(.failure(error!))
                       return
                   }
                   
                   promise(.success(()))
               }
        }
        .eraseToAnyPublisher()
    }
    
    static func fetchAttendanceData(for lectureId: String) -> AnyPublisher<[Bool], Error> {
        return Future { promise in
            ref.child("Attendance")
               .child(lectureId)
               .child(Auth.auth().currentUser?.uid ?? "")
               .getData(completion: { (error, snapshot) in
                   guard error == nil else {
                       promise(.failure(error!))
                       return
                   }
                   
                   let data = snapshot!.value
                   promise(.success(data as! [Bool]))
               })
        }
        .eraseToAnyPublisher()
    }
}
