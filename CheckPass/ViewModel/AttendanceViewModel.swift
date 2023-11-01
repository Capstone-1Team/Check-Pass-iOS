//
//  AttendanceViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/1/23.
//

import Foundation
import Combine

final class AttendanceViewModel: ObservableObject {
    @Published var attendanceStatus: Dictionary<String, [Bool]> = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getUserAttendaceStatus()
    }
    
    func getUserAttendaceStatus() {
        AttendanceRepository.fetchAttendanceStatus()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched user's attendance status")
                case .failure(let error):
                    print("Error: " , error)
                }
            }, receiveValue: { [weak self] in
                print($0)
                self?.attendanceStatus = $0
            })
            .store(in: &cancellables)
    }
}
