//
//  UserViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/08.
//

import Combine
import FirebaseAuth

final class UserViewModel: ObservableObject {
    @Published var user: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getUserInfo()
    }
    
    func getUserInfo() {
        if let userUID = Auth.auth().currentUser?.uid {
            UserRepository.fetchUserInfo(of: userUID)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("successfully fetched User Info")
                    case .failure(let error):
                        print("Error: ", error)
                    }
                }, receiveValue: { [weak self] user in
                    self?.user = user
                })
                .store(in: &cancellables)
        }
    }
}
