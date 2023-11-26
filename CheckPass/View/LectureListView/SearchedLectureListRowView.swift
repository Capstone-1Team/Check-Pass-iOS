//
//  SearchedLectureListRowView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/26/23.
//

import SwiftUI

struct SearchedLectureListRowView: View {
    var lecture: Lecture
    
    private var boon: String {
        lecture.id?.components(separatedBy: "-")[1] ?? "1"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(lecture.LECTURE_NAME) \(boon)분반")
                    .font(.title2)
                    .bold()
                
                Text("\(lecture.PROFESSOR_NAME) 교수님")
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchedLectureListRowView(lecture: Lecture(ATTENDANCE_STATUS: 1, BEACON_MAJOR: 11111, BEACON_MINOR: 22222, BEACON_UUID: "FE850A83-6660-4792-B2CF-886689B32552", DETAILS: "3학년 전필 2학점", LECTURE_NAME: "캡스톤 디자인", LECTURE_ROOM: "미래융합정보관 225호", PROFESSOR_NAME: "홍길동", TOTAL_USER: 50, LECTURE_TIME1: ["금", "1A", "1B"], LECTURE_TIME2: []))
}
