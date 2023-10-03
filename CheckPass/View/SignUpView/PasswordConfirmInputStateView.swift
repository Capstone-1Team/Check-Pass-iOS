//
//  PasswordConfirmInputStateView.swift
//  CheckPass
//
//  Created by 이정훈 on 10/3/23.
//

import SwiftUI

struct PasswordConfirmInputStateView: View {
    @Binding var passwordInput: String
    @Binding var passwordConfirmInput: String
    
    var body: some View {
        if passwordConfirmInput.isEmpty {
            Color.clear
        } else if passwordInput != passwordConfirmInput {
            HStack {
                Image(systemName: "info.circle")
                
                Text("비밀번호가 일치하지 않습니다")
            }
            .foregroundColor(.red)
        }
    }
}

#Preview {
    PasswordConfirmInputStateView(passwordInput: .constant(""), passwordConfirmInput: .constant(""))
}
