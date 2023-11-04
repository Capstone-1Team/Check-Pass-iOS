//
//  ScannedLecturesView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/27.
//

import SwiftUI

struct ScannedLectureListView: View {
    @StateObject private var scannedLecturesViewModel: ScannedLecturesViewModel = ScannedLecturesViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    @State private var showSheet: Bool = false
    
    var body: some View {
        if scannedLecturesViewModel.detectedLectures.isEmpty {
            FlagView()
                .navigationTitle("비콘 출석하기")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                VStack {
                    ForEach(scannedLecturesViewModel.detectedLectures, id: \.id) {
                        ScannedLectureListRowView(showLectureSheet: $showSheet, lecture: $0)
                            .environmentObject(scannedLecturesViewModel)
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                SelectedLectureView(showSheet: $showSheet)
                    .environmentObject(scannedLecturesViewModel)
                    .environmentObject(attendanceViewModel)
                    .environmentObject(userViewModel)
            })
            .navigationTitle("비콘 출석하기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScannedLectureListView()
        .environmentObject(UserViewModel())
}
