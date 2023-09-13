//
//  AuthenticationViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import Combine
import FirebaseAuth

enum AlertType {
    case notExsisting
    case isBlank
}

enum EmailInputState {
    case isExist
    case isIncorrectForm
    case isBlank
    case isValid
}

final class AuthViewModel: ObservableObject {
    @Published var showSignInAlert: Bool = false
    @Published var showMainView: Bool = false
    @Published var isSignInProgress: Bool = false
    @Published var emailInputState: EmailInputState = .isBlank
    @Published var isSignUpProgress: Bool = false
    //@Published var showSignUpError: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    var alertType: AlertType = .isBlank
}

extension AuthViewModel {
    //MARK: - Sign In method
    func signIn(email: String, pw: String) {
        if email.isEmpty || pw.isEmpty {
            alertType = .isBlank
            showSignInAlert = true
            return
        }
        
        isSignInProgress = true
        
        AuthService.authenticationSignIn(email, pw)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.isSignInProgress = false
                    self?.alertType = .notExsisting
                    self?.showSignInAlert = true
                    print("Sing In Error: ", error)
                case .finished:
                    self?.isSignInProgress = false
                    self?.showMainView.toggle()
                    print("successfully signed in")
                }
            }, receiveValue: {
                print("User Sign in")
            })
            .store(in: &cancellables)
    }
    
    func singUp(emailInput: String, pwInput: String, nameInput: String, userIdInput: String, selectedUserType: String) {
        isSignUpProgress = true
        
        AuthService.createUser(emailInput, pwInput)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Sing Up Error: ", error)
                case .finished:
                    self?.showMainView = true
                    print("successfully create User")
                }
            }, receiveValue: { [weak self] in
                if let userUid = Auth.auth().currentUser?.uid {
                    UserService.createUser(userUID: userUid, userName: nameInput, userId: userIdInput, userType: selectedUserType)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                print("successfully created New User Document")
                                self?.isSignUpProgress = false
                            case .failure(let error):
                                self?.isSignUpProgress = false
                                print("Error: ", error)
                            }
                        }, receiveValue: {
                            print("create New User Document")
                        })
                        .store(in: &self!.cancellables)
                }
            })
            .store(in: &cancellables)
    }
}

extension AuthViewModel {
    func checkEmailInput(_ emailInput: String) {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if emailInput.isEmpty {
            emailInputState = .isBlank
        } else if !emailPredicate.evaluate(with: emailInput) {
            emailInputState = .isIncorrectForm
        } else  {
            AuthService.checkExistingEmail(of: emailInput)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Email validation check finished")
                    case .failure(let error):
                        print("Error: ", error)
                    }
                }, receiveValue: { [weak self] in
                    self?.emailInputState = $0
                })
                .store(in: &cancellables)
        }
    }
}
