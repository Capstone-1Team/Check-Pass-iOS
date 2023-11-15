//
//  EAttendanceInfoViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/8/23.
//

import Combine

final class EAttendanceInfoViewModel: ObservableObject {
    @Published var eAttendanceInfo: EAttendanceInfo?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getEAttendanceInfo(lectureId: String?) {
        guard let lectureId = lectureId else {
            return
        }
        
        EAttendanceInfoRepository.fetchElectronicAttendanceInfo(for: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched electronic attendance info")
                case .failure(let error):
                    print("Error: ", error)
                }
            }, receiveValue: { [weak self] info in
                self?.eAttendanceInfo = info
            })
            .store(in: &cancellables)
    }
}
