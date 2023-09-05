//
//  AuthenticationViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var showSignInAlert: Bool = false
    @Published var showMainView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email: String, pw: String) {
        AuthService.authenticationSignIn(email, pw)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.showSignInAlert = true
                    print("Sing In Error: ", error)
                case .finished:
                    self?.showMainView.toggle()
                    print("successfully signed in")
                }
            }, receiveValue: {
                print("sign in...")
            })
            .store(in: &cancellables)
    }
}
