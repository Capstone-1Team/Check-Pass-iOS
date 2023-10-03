//
//  PasswordInputStateView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/10.
//

import SwiftUI

struct PasswordInputStateView: View {
    @Binding var passwordInput: String
    @Binding var passwordInputState: PasswordInputState
    
    var body: some View {
        if passwordInputState == .isBlank {
            Color.clear
                .frame(height: 18.5)
        } else if passwordInput.count < 6 {
            HStack {
                Image(systemName: "info.circle")
                
                Text("6자리 이상 입력하세요")
            }
            .foregroundColor(.red)
        } else if passwordInputState == .isInvalid {
            HStack {
                Image(systemName: "info.circle")
                
                Text("알파벳과 숫자, 특수문자를 포함해야 합니다")
            }
            .foregroundColor(.red)
        } else {
            HStack {
                Image(systemName: "info.circle")
                
                Text("사용 가능한 비밀번호 입니다")
            }
            .foregroundColor(.accentColor)
        }
    }
}

struct PasswordInputStateView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputStateView(passwordInput: .constant(""), passwordInputState: .constant(.isBlank))
    }
}
