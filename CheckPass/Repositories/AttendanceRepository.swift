//
//  AttendanceRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 10/20/23.
//

import Combine
import FirebaseFirestore
import FirebaseAuth

struct AttendanceRepository {
    static private let db = Firestore.firestore()
    
    static func fetchAttendanceStatus() -> AnyPublisher<Dictionary<String, [Bool]>, Error> {
        return Future { promise in
            db.collection("ATTENDANCE").document(Auth.auth().currentUser?.uid ?? "")
                .getDocument { (document, error) in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        if let document = document {
                            promise(.success(document.data() as? Dictionary<String, [Bool]> ?? [:]))
                        }
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
