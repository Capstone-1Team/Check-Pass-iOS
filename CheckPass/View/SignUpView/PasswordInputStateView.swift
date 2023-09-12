//
//  PasswordInputStateView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/10.
//

import SwiftUI

struct PasswordInputStateView: View {
    @Binding var passwordInput: String
    @Binding var passwordInputCheck: String
    
    var body: some View {
        if passwordInput != passwordInputCheck {
            HStack {
                Image(systemName: "info.circle")
                
                Text("비밀번호가 일치하지 않습니다.")
            }
            .foregroundColor(.red)
        } else if passwordInput.count < 6 && !passwordInput.isEmpty {
            HStack {
                Image(systemName: "info.circle")
                
                Text("비밀번호는 6자(영문 기준) 이상이어야 합니다")
            }
            .foregroundColor(.red)
        }
    }
}

struct PasswordInputStateView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputStateView(passwordInput: .constant(""), passwordInputCheck: .constant(""))
    }
}
