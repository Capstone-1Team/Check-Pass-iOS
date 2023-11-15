//
//  AttendanceViewModel.swift
//  CheckPass
//
//  Created by 이정훈 on 11/1/23.
//

import Foundation
import Combine

final class AttendanceViewModel: ObservableObject {
    @Published var attendanceData: Dictionary<String, [Bool]> = [:]
    @Published var isComplete: Bool = false
    @Published var isProgress: Bool = false
    @Published var showAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    var alertType: AttendanceAlertType = .unknowned
    
    func attendLecture(for lectureId: String) {
        AttendanceRepository.setAttendanceData(for: lectureId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("successfully set attendance data")
                case .failure(let error):
                    print("Error: ", error)
                    self?.alertType = .unknowned
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
                        print("successfully fetched User attendance data")
                    case .failure(let error):
                        print("Error: ", error)
                    }
                }, receiveValue: { [weak self] in
                    self?.attendanceData[lectureId] = $0
                })
                .store(in: &cancellables)
        }
    }
    
    func checkMatch(attInfo: EAttendanceInfo?, codeInputs: String, lectureId: String) {
        guard let attInfo = attInfo else {
            alertType = .unknowned
            return
        }
        
        if Date().isAfter(about: attInfo.START_STAMP.dateValue()) && Date().isBefore(about: attInfo.END_STAMP.dateValue()) {
            if attInfo.RANDOM_CODE == codeInputs {
                attendLecture(for: lectureId)
                alertType = .matched
                showAlert = true
            } else {
                alertType = .notMached
                showAlert = true
            }
        } else {
            alertType = .notPeriod
            showAlert = true
        }
    }
}

enum AttendanceAlertType {
    case notPeriod
    case matched
    case notMached
    case unknowned
}

extension Date {
    func isBefore(about target: Date?) -> Bool {
        if let target = target {
            let compareResult = self.compare(target)
            
            switch compareResult {
            case .orderedDescending:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    func isAfter(about target: Date?) -> Bool {
        if let target = target {
            let compareResult = self.compare(target)
            
            switch compareResult {
            case .orderedAscending:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
}
