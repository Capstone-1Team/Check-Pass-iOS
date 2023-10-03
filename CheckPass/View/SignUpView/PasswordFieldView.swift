//
//  TextFieldView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/10.
//

import SwiftUI

struct PasswordFieldView: View {
    @Binding var textInput: String
    @FocusState private var isFocused: Bool?
    
    var title: String
    var keyboardFocus: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "lock")
                
                SecureField(title, text: $textInput)
                    .font(.title3)
                    .focused($isFocused, equals: true)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
        .onAppear {
            if keyboardFocus {
                isFocused = true
            }
        }
    }
}

struct PasswordFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordFieldView(textInput: .constant(""), title: "비밀번호를 입력 하세요.", keyboardFocus: false)
    }
}
