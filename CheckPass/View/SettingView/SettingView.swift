//
//  SettingView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/13.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showSignOutAlert: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("로그인 관리")) {
                Button(action: {
                    showSignOutAlert = true
                }, label: {
                    Text("로그아웃")
                        .foregroundColor(.red)
                })
            }
        }
        .listStyle(.plain)
        .alert(isPresented: $showSignOutAlert) {
            Alert(title: Text("알림"), message: Text("로그아웃 할까요?"), primaryButton: .destructive(Text("로그아웃"), action: {
                authViewModel.signOut()
            }), secondaryButton: .cancel(Text("취소")))
        }
        .safeAreaInset(edge: .top, content: {
            HStack {
                Text("더보기")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                
                Spacer()
            }
            .padding([.top, .bottom])
            .background(colorScheme == .light ? .white : .black)
        })
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AuthViewModel())
    }
}
