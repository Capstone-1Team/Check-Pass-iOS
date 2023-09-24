//
//  MainUserInfoVIew.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/17.
//

import SwiftUI

struct MainUserInfoVIew: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: UIScreen.main.bounds.width * 0.4)
                .foregroundColor(colorScheme == .light ? .white : Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255))
                .shadow(radius: 3)
            
            HStack(alignment: .top) {
                if let user = userViewModel.user {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                        
                        if !user.PROFILE_IMAGE.isEmpty {
                            AsyncImage(url: URL(string: user.PROFILE_IMAGE), content: { image in
                                image
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.width * 0.23)
                            }, placeholder: {
                                ZStack {
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.width * 0.23)
                                    
                                    ProgressView()
                                }
                            })
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.width * 0.23)
                        }
                    }
                    .padding([.leading, .trailing])
                    
                    VStack(alignment: .leading) {
                        Text(userViewModel.user?.USER_NAME ?? "")
                            .bold()
                            .font(.title2)
                        
                        if userViewModel.user?.USER_TYPE == .student {
                            Text("학번: \(userViewModel.user?.USER_NUMBER ?? "")")
                                .font(.subheadline)
                        } else {
                            Text("교직원 번호: \(userViewModel.user?.USER_NUMBER ?? "")")
                                .font(.subheadline)
                        }
                        
                        Text("소속: \(userViewModel.user?.DEPARTMENT[0] ?? "")")
                            .font(.subheadline)
                        
                        Text("         \(userViewModel.user?.DEPARTMENT[1] ?? "")")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                } else {
                    ProgressView()
                }
            }
        }
    }
}

struct MainUserInfoVIew_Previews: PreviewProvider {
    static var previews: some View {
        MainUserInfoVIew()
            .environmentObject(UserViewModel())
    }
}
