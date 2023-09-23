//
//  UserRepository.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/07.
//

import Combine
import FirebaseFirestore

struct UserRepository {
    static let db = Firestore.firestore()
    
    static func fetchUserInfo(of userUID: String) -> AnyPublisher<User, Error> {
        return Future { promise in
            let docRef = db.collection("USERS").document(userUID)

            docRef.getDocument { (document, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    if let document = document {
                        let data = document.data()
                        let USER_NUMBER = data?["USER_NUMBER"] as? String ?? ""
                        let LECTURES = data?["LECTURES"] as? [String] ?? []
                        let PROFILE_IMAGE = data?["PROFILE_IMAGE"] as? String ?? ""
                        let USER_NAME = data?["USER_NAME"] as? String ?? ""
                        let USER_TYPE = UserType(rawValue: data?["USER_TYPE"] as? String ?? "") ?? UserType.unknown
                        let DEPARTMENT = data?["DEPARTMENT"] as? [String] ?? []
                        
                        let user = User(USER_NUMBER: USER_NUMBER, LECTURES: LECTURES, PROFILE_IMAGE: PROFILE_IMAGE, USER_NAME: USER_NAME, USER_TYPE: USER_TYPE, DEPARTMENT: DEPARTMENT)
                        
                        promise(.success(user))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    ///create new User userId: Firebase User UID, userName: User Name, idNum: University  ID Number, userType: User Type
    static func createUser(userUID: String, userName: String, userNum: String, userType: String, department: [String]) -> AnyPublisher<Void, Error> {
        return Future { promise in
            let docData: [String: Any] = [
                "USER_NUMBER": userNum,
                "LECTURES": [] as [String],
                "PROFILE_IMAGE": "",
                "USER_NAME": userName,
                "USER_TYPE": userType,
                "DEPARTMENT": department
            ]
            
            db.collection("USERS").document(userUID).setData(docData) { error in
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
