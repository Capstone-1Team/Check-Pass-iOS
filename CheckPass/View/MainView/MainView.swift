//
//  MainView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/13.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    @StateObject var attendanceViewModel: AttendanceViewModel = AttendanceViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                MainUserInfoVIew()
                    .environmentObject(userViewModel)
                    .padding(.bottom, 6)
                
                HStack {
                    NavigationLink(destination: {
                        ScannedLectureListView()
                            .environmentObject(attendanceViewModel)
                            .environmentObject(userViewModel)
                    }, label: {
                        MainAttendanceCardView(title: "비콘", colorFrom: .blue, colorTo: Color(red: 129 / 255, green: 39 / 255, blue: 228 / 255))
                            .padding(.trailing, 3)
                    })
                    
                    NavigationLink(destination: {}, label: {
                        MainAttendanceCardView(title: "전자", colorFrom: .blue, colorTo: Color(red: 0 / 255, green: 180 / 255, blue: 219 / 255))
                            .padding(.leading, 3)
                    })
                }
                .padding(.bottom, 6)
                
                AttendanceStatusView()
            }
            .padding([.leading, .trailing])
        }
        .onChange(of: userViewModel.user, perform: { newUser in
            attendanceViewModel.getAttendanceData(lectures: newUser?.LECTURES)
        })
        .safeAreaInset(edge: .top, content: {
            HStack {
                Text("CHECKPASS")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.leading)
                
                Spacer()
            }
            .padding([.top, .bottom], 8)
            .background(colorScheme == .light ? .white : .black)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
