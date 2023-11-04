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
    @Published var attendanceData: Dictionary<String, [Bool]> = [:]
    
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
                    
                    if !user.LECTURES.isEmpty {
                        self?.getAttendanceData()
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    func getAttendanceData() {
        user?.LECTURES.forEach { lectureId in
            AttendanceRepository.fetchAttendanceData(for: lectureId)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("successfully fetch User attendance data")
                    case .failure(let error):
                        print("Error: ", error)
                    }
                }, receiveValue: { [weak self] in
                    self?.attendanceData[lectureId] = $0
                })
                .store(in: &cancellables)
        }
    }
}
