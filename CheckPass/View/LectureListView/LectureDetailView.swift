//
//  LectureDetailView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/15/23.
//

import SwiftUI

struct LectureDetailView: View {
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    
    var lecture: Lecture
    private var boon: String {
        lecture.id?.components(separatedBy: "-")[1] ?? "1"
    }
    
    var body: some View {
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
            
            Text("출석 현황")
                .bold()
                .padding(.top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: UIScreen.main.bounds.width * 0.3)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        if let id = lecture.id {
                            ForEach(1...8, id: \.self) { week in
                                if let isAttend = attendanceViewModel.attendanceData[id]?[week - 1] {
                                    WeekAttendanceStatus(week: week, isAttend: isAttend)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        if let id = lecture.id {
                            ForEach(9...16, id: \.self) { week in
                                if let isAttend = attendanceViewModel.attendanceData[id]?[week - 1] {
                                    WeekAttendanceStatus(week: week, isAttend: isAttend)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("강의 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LectureDetailView(lecture: Lecture(ATTENDANCE_STATUS: 1, BEACON_MAJOR: 11111, BEACON_MINOR: 22222, BEACON_UUID: "FE850A83-6660-4792-B2CF-886689B32552", DETAILS: "3학년 전필 2학점", LECTURE_NAME: "캡스톤 디자인", LECTURE_ROOM: "미래융합정보관 225호", PROFESSOR_NAME: "홍길동", TOTAL_USER: 50, LECTURE_TIME1: ["금", "1A", "1B"], LECTURE_TIME2: []))
        .environmentObject(AttendanceViewModel())
}
