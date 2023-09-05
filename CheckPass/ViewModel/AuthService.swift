//
//  AuthenticationService.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Foundation
import Combine
import FirebaseAuth

struct AuthService {
    /// sign in method for Existing User
    static func authenticationSignIn(_ email: String, _ pw: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: pw) { (authResult, error) in
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
