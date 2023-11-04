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
}
