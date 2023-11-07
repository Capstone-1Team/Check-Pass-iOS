//
//  LectureViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/5/23.
//

import Combine

final class LectureViewModel: ObservableObject {
    @Published var lectures: [Lecture] = []
    
    private var cancellables = Set<AnyCancellable>()
    var selectedLecture: Lecture?
    
    func getLecture(lectureIds: [String]) {
        if !lectureIds.isEmpty {
            lectures.removeAll()
            
            lectureIds.forEach {
                LectureRepository.fetchLecture(lectureId: $0)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("successfully fetched lecture")
                        case .failure(let error):
                            print("Error: ", error)
                        }
                    }, receiveValue: { [weak self] lecture in
                        self?.lectures.append(lecture)
                    })
                    .store(in: &cancellables)
            }
        }
    }
}
