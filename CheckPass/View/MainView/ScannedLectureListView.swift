//
//  DetectedLecturesView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/27.
//

import SwiftUI

struct ScannedLectureListView: View {
    @StateObject var detectedLecturesViewModel: ScannedLecturesViewModel = ScannedLecturesViewModel()
    
    var body: some View {
        if detectedLecturesViewModel.detectedLectures.isEmpty {
            FlagView()
                .navigationTitle("비콘 출석하기")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                VStack {
                    ForEach(detectedLecturesViewModel.detectedLectures, id: \.id) {
                        ScannedLectureListRowView(lecture: $0)
                            .padding()
                    }
                }
            }
            .navigationTitle("비콘 출석하기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScannedLectureListView()
}
