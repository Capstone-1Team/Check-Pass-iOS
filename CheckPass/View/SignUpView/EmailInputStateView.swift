//
//  EmailInputStateView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/08.
//

import SwiftUI

struct EmailInputStateView: View {
    @Binding var emailInputState: EmailInputState
    
    var body: some View {
        if emailInputState == .isExist {
            HStack {
                Image(systemName: "info.circle")
                
                Text("이미 존재하는 이메일입니다.")
            }
            .foregroundColor(.red)
        } else if emailInputState == .isIncorrectForm {
            HStack {
                Image(systemName: "info.circle")
                
                Text("잘못된 이메일 형식입니다.")
            }
            .foregroundColor(.red)
        } else if emailInputState == .isValid {
            HStack {
                Image(systemName: "info.circle")
                
                Text("사용 가능한 이메일입니다.")
            }
            .foregroundColor(.accentColor)
        }
    }
}

struct EmailInputStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmailInputStateView(emailInputState: .constant(.isBlank))
    }
}
