//
//  UserAttendanceCarView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/4/23.
//

import SwiftUI

struct UserAttendanceCardView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var scannedLecturesViewModel: ScannedLecturesViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
            
            VStack {
                HStack {
                    Text(scannedLecturesViewModel.selectedLecture?.LECTURE_NAME ?? "")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack {
                    Text(scannedLecturesViewModel.selectedLecture?.LECTURE_ROOM ?? "")
                    
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.width * 0.33)
                    
                    if let user = userViewModel.user {
                        AsyncImage(url: URL(string: user.PROFILE_IMAGE), content: { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.33)
                        }, placeholder: {
                            ZStack {
                                Circle()
                                    .fill(.gray)
                                    .frame(width: UIScreen.main.bounds.width * 0.33, height: UIScreen.main.bounds.width * 0.33)
                                
                                ProgressView()
                            }
                        })
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                    }
                }
                
                Text(userViewModel.user?.USER_NAME ?? "")
                    .tracking(16)
                    .offset(x: 8)
                    .bold()
                    .font(.title)
                    .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("학        번: \(userViewModel.user?.USER_NUMBER ?? "")")
                        .foregroundColor(.black)
                    
                    Text("소        속: \(userViewModel.user?.DEPARTMENT[0] ?? "")")
                        .foregroundColor(.black)
                    
                    Text("학        과: \(userViewModel.user?.DEPARTMENT[1] ?? "")")
                        .foregroundColor(.black)
                    
                    Text("현재 시간: \(Date().getCurrentDateString())")
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

extension Date {
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: self)
    }
}

#Preview {
    UserAttendanceCardView()
        .environmentObject(ScannedLecturesViewModel())
        .environmentObject(UserViewModel())
}
