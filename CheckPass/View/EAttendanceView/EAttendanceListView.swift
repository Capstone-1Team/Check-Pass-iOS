//
//  EAttendanceListView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/6/23.
//

import SwiftUI

struct EAttendanceListView: View {
    @EnvironmentObject var lectureViewModel: LectureViewModel
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        if !lectureViewModel.lectures.isEmpty {
            ScrollView {
                ForEach(lectureViewModel.lectures) { lecture in
                    EAttendanceListRowView(showSheet: $showSheet, lecture: lecture)
                        .padding([.leading, .bottom, .trailing])
                }
            }
            .navigationTitle("전자 출석하기")
            .sheet(isPresented: $showSheet) {
                SelectedLectureDetailView(showSheet: $showSheet)
                    .environmentObject(lectureViewModel)
                    .environmentObject(attendanceViewModel)
            }
        } else {
            NoLectureView()
                .navigationTitle("전자 출석하기")
        }
    }
}

#Preview {
    EAttendanceListView()
        .environmentObject(LectureViewModel())
        .environmentObject(AttendanceViewModel())
}
