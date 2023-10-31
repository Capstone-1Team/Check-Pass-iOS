//
//  DetectedLecturesViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/26.
//

import Combine

final class ScannedLecturesViewModel: ObservableObject {
    @Published var detectedLectures: [Lecture] = []
    @Published var selectedLecture: Lecture?
    
    private var beaconService: BeaconService?
    private var cancellabes = Set<AnyCancellable>()
    
    init() {
        getBeaconList()
    }
    
    func getBeaconList() {
        BeaconsRepository.fetchBeaconUUIDList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched Beacon List")
                case .failure(let error):
                    print("Error: ", error)
                }
            }, receiveValue: { [weak self] beaconUUIDList in
                self?.beaconService = BeaconService(beaconUUIDList)
                let publisher = self?.beaconService?.$detectedBeaconInfo
                
                publisher?.sink(receiveValue: {
                    LectureRepository.fetchScannedLecture($0)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                print("successfully feched detected Lecture")
                            case .failure(let error):
                                print("Error: ", error)
                            }
                        }, receiveValue: { [weak self] lecture in
                            self?.detectedLectures.append(lecture)
                            print("detectedLectures: \(self?.detectedLectures ?? [])")
                        })
                        .store(in: &self!.cancellabes)
                })
                .store(in: &self!.cancellabes)
            })
            .store(in: &cancellabes)
    }
    
//    func getAttendanceStatus(for lectureId: String?) {
//        
//    }
}
