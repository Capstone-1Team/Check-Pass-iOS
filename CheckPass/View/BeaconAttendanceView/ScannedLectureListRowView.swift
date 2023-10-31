//
//  DetectedLectureListRowView.swift
//  CheckPass
//
//  Created by 이정훈 on 10/1/23.
//

import SwiftUI

struct ScannedLectureListRowView: View {
    @EnvironmentObject var scannedLecturesViewModel: ScannedLecturesViewModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var showLectureSheet: Bool
    
    var lecture: Lecture
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(colorScheme == .light ? .white : Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255))
                .shadow(radius: 3)
            
            VStack(alignment: .leading) {
                Text(lecture.LECTURE_NAME)
                    .font(.title)
                    .bold()
                
                HStack {
                    Text("\(lecture.PROFESSOR_NAME) 교수님")
                    
                    Spacer()
                    
                    Text(lecture.LECTURE_ROOM)
                }
                .foregroundColor(.gray)
                .padding(.bottom)
                
                Button(action:{
                    showLectureSheet.toggle()
                    scannedLecturesViewModel.selectedLecture = lecture
                }, label: {
                    Text("출석하기")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(30)
                })
            }
            .padding()
        }
    }
}

#Preview {
    ScannedLectureListRowView(showLectureSheet: .constant(false), lecture: Lecture(ATTENDANCE_STATUS: 1, BEACON_MAJOR: 11111, BEACON_MINOR: 22222, BEACON_UUID: "FE850A83-6660-4792-B2CF-886689B32552", CREDIT: "2", GRADE: "3", LECTURE_NAME: "캡스톤 디자인", LECTURE_ROOM: "미래융합정보관 225호", PROFESSOR_NAME: "홍길동", TOTAL_USER: 50))
        .environmentObject(ScannedLecturesViewModel())
}
