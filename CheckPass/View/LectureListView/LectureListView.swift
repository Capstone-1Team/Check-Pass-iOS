//
//  LectureListView.swift
//  CheckPass
//
//  Created by 이정훈 on 9/27/23.
//

import SwiftUI

struct LectureListView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var lectureViewModel: LectureViewModel
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        List {
            ForEach(lectureViewModel.lectures) { lecture in
                NavigationLink(destination: LectureDetailView(lecture: lecture).environmentObject(attendanceViewModel), label: {
                    Text(lecture.LECTURE_NAME)
                        .font(.title3)
                        .padding([.top, .bottom], 8)
                })
            }
            .onDelete(perform: { _ in})
        }
        .listStyle(.plain)
        .safeAreaInset(edge: .top, content: {
            VStack {
                HStack {
                    Text("내 강의")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    })
                    .padding(.trailing)
                }
                .padding([.top], 8)
                
                Divider()
            }
            .background(colorScheme == .light ? .white : .black)
        })
        .sheet(isPresented: $showSheet, content: {
            SearchedLectureListView()
                .environmentObject(lectureViewModel)
        })
    }
}

#Preview {
    LectureListView()
        .environmentObject(LectureViewModel())
        .environmentObject(AttendanceViewModel())
}
