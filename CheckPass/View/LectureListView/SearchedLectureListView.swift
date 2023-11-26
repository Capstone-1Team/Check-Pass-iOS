//
//  SearchedLectureListView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/26/23.
//

import SwiftUI

struct SearchedLectureListView: View {
    @EnvironmentObject var lectureViewModel: LectureViewModel
    
    @State private var keyword: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lectureViewModel.searchedLectures) { lecture in
                    NavigationLink(destination: {
                        SearchedLectureDetailView(lecture: lecture)
                    }, label: {
                        SearchedLectureListRowView(lecture: lecture)
                    })
                }
            }
            .onChange(of: keyword) {
                lectureViewModel.getSearchedLecture(for: $0)
            }
            .listStyle(.plain)
            .searchable(text: $keyword)
            .navigationTitle("강의 찾기")
        }
    }
}

#Preview {
    SearchedLectureListView()
        .environmentObject(LectureViewModel())
}
