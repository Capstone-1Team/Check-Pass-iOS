//
//  LectureRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 10/1/23.
//

import Combine
import FirebaseFirestore

struct LectureRepository {
    static private let db = Firestore.firestore()
    
    static func fetchScannedLecture(beaconInfo: BeaconInfo) -> AnyPublisher<Lecture, Error> {
        return Future { promise in
            db.collection("LECTURES")
                .whereField("BEACON_UUID", isEqualTo: beaconInfo.0)
                .whereField("BEACON_MAJOR", isEqualTo: beaconInfo.1)
                .whereField("BEACON_MINOR", isEqualTo: beaconInfo.2)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        querySnapshot?.documents.forEach { document in
                            do {
                                let lecture = try document.data(as: Lecture.self)
                                promise(.success(lecture))
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    static func fetchLecture(lectureId: String) -> AnyPublisher<Lecture, Error> {
        return Future { promise in
            db.collection("LECTURES")
              .document(lectureId)
              .getDocument(as: Lecture.self) { result in
                  switch result {
                  case .success(let lecture):
                      promise(.success(lecture))
                  case .failure(let error):
                      promise(.failure(error))
                  }
              }
        }
        .eraseToAnyPublisher()
    }
}
