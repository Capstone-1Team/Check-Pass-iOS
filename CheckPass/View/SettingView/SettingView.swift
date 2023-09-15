//
//  SettingView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/13.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
        .alert(isPresented: $showSignOutAlert) {
            Alert(title: Text("알림"), message: Text("로그아웃 할까요?"), primaryButton: .destructive(Text("로그아웃"), action: {
                authViewModel.signOut()
            }), secondaryButton: .cancel(Text("취소")))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AuthViewModel())
    }
}
