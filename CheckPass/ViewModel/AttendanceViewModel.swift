//
//  AttendanceViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/1/23.
//

import Foundation
import Combine

final class AttendanceViewModel: ObservableObject {
    @Published var isComplete: Bool = false
    @Published var attendanceData: Dictionary<String, [Bool]> = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    func attendLecture(for lectureId: String) {
        AttendanceRepository.setAttendanceData(for: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully set attendance data")
                case .failure(let error):
                    print("Error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.isComplete = true
            })
            .store(in: &cancellables)
    }
    
    func getAttendanceData(lectures: [String]?) {
        lectures?.forEach { lectureId in
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
