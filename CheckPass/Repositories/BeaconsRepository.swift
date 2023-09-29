//
//  BeaconsRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 9/28/23.
//

import Combine
import Firebase

struct BeaconsRepository {
    static private let db = Firestore.firestore()
    
    static func fetchBeaconUUIDList() -> AnyPublisher<[String], Error> {
        return Future { promise in
            db.collection("BEACONS").getDocuments { (querySnapshot, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    //Beacon UUID List
                    let documentList = querySnapshot!.documents.map {
                        $0.documentID
                    }
                    
                    promise(.success(documentList))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
