//
//  SearchedLectureDetailView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/26/23.
//

import SwiftUI

struct SearchedLectureDetailView: View {
    var lecture: Lecture
    private var boon: String {
        lecture.id?.components(separatedBy: "-")[1] ?? "1"
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(lecture.LECTURE_NAME) \(boon)분반")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                }
                
                HStack {
                    Text("\(lecture.PROFESSOR_NAME) 교수님")
                    
                    Spacer()
                    
                    Text(lecture.DETAILS)
                }
                .padding(.bottom)
                
                Text("강의 시간")
                    .bold()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: UIScreen.main.bounds.width * 0.2)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(lecture.LECTURE_TIME1.joined(separator: " "))
                            
                            if !lecture.LECTURE_TIME2.isEmpty {
                                Text("/  \(lecture.LECTURE_TIME2.joined(separator: " "))")
                            }
                            
                            Spacer()
                        }
                        
                        Text(lecture.LECTURE_ROOM)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .offset(y: -50 )
            
            Button(action: {}, label: {
                GradiantTextView(label: "추가하기", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
            })
        }
        .padding()
    }
}

#Preview {
    SearchedLectureDetailView(lecture: Lecture(ATTENDANCE_STATUS: 1, BEACON_MAJOR: 11111, BEACON_MINOR: 22222, BEACON_UUID: "FE850A83-6660-4792-B2CF-886689B32552", DETAILS: "3학년 전필 2학점", LECTURE_NAME: "캡스톤 디자인", LECTURE_ROOM: "미래융합정보관 225호", PROFESSOR_NAME: "홍길동", TOTAL_USER: 50, LECTURE_TIME1: ["금", "1A", "1B"], LECTURE_TIME2: []))
}
