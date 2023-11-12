//
//  EAttendanceInfoRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Combine
import FirebaseFirestore

struct EAttendanceInfoRepository {
    static private let db = Firestore.firestore()
    
    static func fetchElectronicAttendanceInfo(for lectureId: String) -> AnyPublisher<EAttendanceInfo, Error> {
        return Future { promise in
            db.collection("E-ATTENDANCE")
                .document(lectureId)
                .getDocument(as: EAttendanceInfo.self) { result in
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
