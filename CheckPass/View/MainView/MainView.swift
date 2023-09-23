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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                MainUserInfoVIew()
                    .environmentObject(userViewModel)
                    .padding(.bottom, 6)
                
                HStack {
                    MainAttendanceCardView()
                        .padding(.trailing, 3)
                    
                    MainAttendanceCardView()
                        .padding(.leading, 3)
                }
                .padding(.bottom)
            }
            .padding([.leading, .trailing])
        }
        .safeAreaInset(edge: .top, content: {
            HStack {
                Text("CHECKPASS")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.leading)
                
                Spacer()
            }
            .padding([.top, .bottom])
            .background(colorScheme == .light ? .white : .black)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
