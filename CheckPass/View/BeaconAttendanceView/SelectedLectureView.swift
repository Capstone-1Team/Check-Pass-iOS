//
//  SelectedLectureView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/4/23.
//

import SwiftUI

struct SelectedLectureView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var scannedLecturesViewModel: ScannedLecturesViewModel
    @EnvironmentObject var attendanceViewModel: AttendanceViewModel
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack {
            Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                .ignoresSafeArea()
            
            VStack {
                UserAttendanceCardView()
                    .environmentObject(scannedLecturesViewModel)
                    .environmentObject(userViewModel)
                    .padding([.leading, .trailing, .top])
                
                Image("arrow")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 10)
                
                Button(action: {
                    attendanceViewModel.attendLecture(for: scannedLecturesViewModel.selectedLecture!.id ?? "")
                }, label: {
                    GradiantTextView(label: "출석하기", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
                })
                .padding([.leading, .trailing, .bottom])
                .alert(isPresented: $attendanceViewModel.isComplete, content: {
                    Alert(title: Text("알림"), message: Text("출석을 완료했어요"), dismissButton: .default(Text("확인"), action: {
                        attendanceViewModel.getAttendanceData(lectures: userViewModel.user?.LECTURES)
                        self.showSheet.toggle()
                    }))
                })
            }
        }
    }
}

#Preview {
    SelectedLectureView(showSheet: .constant(true))
        .environmentObject(ScannedLecturesViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(AttendanceViewModel())
}
