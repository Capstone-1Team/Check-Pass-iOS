//
//  DetectedLecturesView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/27.
//

import SwiftUI

struct ScannedLectureListView: View {
    @StateObject private var scannedLecturesViewModel: ScannedLecturesViewModel = ScannedLecturesViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showLectureSheet: Bool = false
    
    var body: some View {
        if scannedLecturesViewModel.detectedLectures.isEmpty {
            FlagView()
                .navigationTitle("비콘 출석하기")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                VStack {
                    ForEach(scannedLecturesViewModel.detectedLectures, id: \.id) {
                        ScannedLectureListRowView(showLectureSheet: $showLectureSheet, lecture: $0)
                            .environmentObject(scannedLecturesViewModel)
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showLectureSheet, content: {
                SelectedLectureView()
                    .environmentObject(scannedLecturesViewModel)
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
