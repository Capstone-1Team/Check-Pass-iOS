//
//  AuthService.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Combine
import FirebaseAuth

struct AuthService {
    /// sign in method for Existing User
    static func signIn(_ email: String, _ pw: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: pw) { (_, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// sign up method for new client
    static func createUser(_ email: String, _ pw: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: pw) { (_, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func checkExistingEmail(of email: String) -> AnyPublisher<EmailInputState, Error> {
        return Future { promise in
            Auth.auth().fetchSignInMethods(forEmail: email) { ( signInMethod, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    if signInMethod != nil {
                        promise(.success(EmailInputState.isExist))
                    } else {
                        promise(.success(EmailInputState.isValid))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
