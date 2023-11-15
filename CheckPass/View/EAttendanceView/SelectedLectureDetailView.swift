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
    @State private var codeInputs: [String] = ["", "", "", ""]
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                
                Image(systemName: "house.fill")
                    .padding(.trailing, -7)
                
                Text(lectureViewModel.selectedLecture?.LECTURE_ROOM ?? "")
            }
            .font(.footnote)
            .padding(.top)
            
            VStack {
                HStack {
                    Text(lectureViewModel.selectedLecture?.LECTURE_NAME ?? "")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                HStack {
                    Text("화면에 생성된 코드를 입력하세요")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    
                    Spacer()
                }
            }
            
            HStack(spacing: 20) {
                ForEach(codeInputs.indices, id:\.self) { index in
                    if index == 0 {
                        CodeInputView(codeInput: $codeInputs[index], keyboardFocus: true)
                    } else {
                        CodeInputView(codeInput: $codeInputs[index], keyboardFocus: false)
                    }
                }
            }
            
            Spacer()
            
            if !attendanceViewModel.isProgress {
                Button(action:{
                    attendanceViewModel.isProgress.toggle()
                    eAttendanceViewModel.getEAttendanceInfo(lectureId: lectureViewModel.selectedLecture?.id)
                }, label: {
                    GradiantTextView(label: "출석하기", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
                })
            } else {
                ZStack {
                    GradiantTextView(label: " ", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
                    
                    ProgressView()
                }
            }
        }
        .padding()
        .onChange(of: eAttendanceViewModel.eAttendanceInfo) {
            attendanceViewModel.checkMatch(attInfo: $0, codeInputs: codeInputs.joined(separator: ""), lectureId: lectureViewModel.selectedLecture?.id ?? "")
        }
        .alert(isPresented: $attendanceViewModel.showAlert) {
            switch attendanceViewModel.alertType {
            case .notPeriod:
                Alert(title: Text("알림"), message: Text("출석 가능 시간이 아니에요"), dismissButton: .default(Text("확인"), action: {
                    eAttendanceViewModel.eAttendanceInfo = nil
                    attendanceViewModel.isProgress.toggle()
                }))
            case .matched:
                Alert(title: Text("알림"), message: Text("출석을 완료 했어요"), dismissButton: .default(Text("확인"), action: {
                    eAttendanceViewModel.eAttendanceInfo = nil
                    attendanceViewModel.isProgress.toggle()
                    showSheet = false
                }))
            case .notMached:
                Alert(title: Text("알림"), message: Text("코드가 일치하지 않아요"), dismissButton: .default(Text("확인"), action: {
                    eAttendanceViewModel.eAttendanceInfo = nil
                    attendanceViewModel.isProgress.toggle()
                }))
            case .unknowned:
                Alert(title: Text("알 수 없는 오류"))
            }
        }
    }
}

#Preview {
    SelectedLectureDetailView(showSheet: .constant(true))
        .environmentObject(LectureViewModel())
        .environmentObject(AttendanceViewModel())
}
