//
//  UserService.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/07.
//

import Combine
import Foundation
import FirebaseFirestore

struct UserService {
    static let db = Firestore.firestore()
    
//    static func fetchUserInfo(_ userId: String) -> AnyPublisher<User, Error> {
//        return Future { promise in
//            let docRef = db.collection("USER").document(userId)
//
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    //docuemnt parsing
//                }
//            }
//        }
//        .eraseToAnyPublisher()
//    }
    
    ///create new User userId: Firebase User UID, userName: User Name, idNum: University  ID Number, userType: User Type
    static func createUser(userUID: String, userName: String, userId: String, userType: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            let docData: [String: Any] = [
                "ID": userId,
                "LACTURES": [] as [String],
                "PROFILE_IMAGE": "",
                "USER_NAME": userName,
                "USER_TYPE": userType
            ]
            
            db.collection("UERS").document(userUID).setData(docData) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
