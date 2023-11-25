//
//  LectureListRowView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/15/23.
//

import SwiftUI

struct LectureListRowView: View {
    @Environment(\.colorScheme) var colorScheme
    var lecture: Lecture
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(colorScheme == .light ? .white : Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255))
                .shadow(radius: 3)
            
            VStack(spacing: 40) {
                HStack {
                    Text(lecture.LECTURE_NAME)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                
                HStack {
                    Text("\(lecture.PROFESSOR_NAME) 교수님")
                    
                    Spacer()
                    
                    Text(lecture.LECTURE_ROOM)
                }
                .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

#Preview {
    LectureListRowView(lecture: Lecture(ATTENDANCE_STATUS: 1, BEACON_MAJOR: 11111, BEACON_MINOR: 22222, BEACON_UUID: "FE850A83-6660-4792-B2CF-886689B32552", DETAILS: "3학년 전필 2학점", LECTURE_NAME: "캡스톤 디자인", LECTURE_ROOM: "미래융합정보관 225호", PROFESSOR_NAME: "홍길동", TOTAL_USER: 50, LECTURE_TIME1: ["금", "1A", "1B"], LECTURE_TIME2: []))
}
