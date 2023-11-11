//
//  EAttendanceInfoViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Combine

final class EAttendanceInfoViewModel: ObservableObject {
    @Published var electronicAttendanceInfo: ElectronicAttendanceInfo?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getElectronicAttendanceInfo(lectureId: String) {
        ElectronicAttendanceInfoRepository.fetchElectronicAttendanceInfo(for: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched electronic attendance info")
                case .failure(let error):
                    print("Error: ", error)
                }
            }, receiveValue: { [weak self] info in
                self?.electronicAttendanceInfo = info
            })
            .store(in: &cancellables)
    }
}
