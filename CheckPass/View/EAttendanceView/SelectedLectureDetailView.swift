//
//  SelectedLectureDetailView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/7/23.
//

import SwiftUI

struct SelectedLectureDetailView: View {
    @StateObject var eAttendanceViewModel: EAttendanceInfoViewModel = EAttendanceInfoViewModel()
    @EnvironmentObject var lectureViewModel: LectureViewModel
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    @State var codeInput: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            CodeInputView(codeInput: $codeInput, placeholder: "전송할 코드를 입력하세요")
            
            Button(action:{}, label: {
                GradiantTextView(label: "출석하기", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
            })
        }
        .padding()
    }
}

#Preview {
    SelectedLectureDetailView()
        .environmentObject(LectureViewModel())
        .environmentObject(AttendanceViewModel())
}
