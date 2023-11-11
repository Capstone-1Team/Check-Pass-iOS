//
//  ElectronicAttendanceInfoRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Combine
import FirebaseFirestore

struct ElectronicAttendanceInfoRepository {
    static private let db = Firestore.firestore()
    
    static func fetchElectronicAttendanceInfo(for lectureId: String) -> AnyPublisher<ElectronicAttendanceInfo, Error> {
        return Future { promise in
            db.collection("E-Attendance")
                .document(lectureId)
                .getDocument(as: ElectronicAttendanceInfo.self) { result in
                    switch result {
                    case .success(let info):
                        promise(.success(info))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
