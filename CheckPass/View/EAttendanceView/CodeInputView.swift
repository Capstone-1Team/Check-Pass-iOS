//
//  CodeInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/7/23.
//

import SwiftUI

struct CodeInputView: View {
    @FocusState var isFocused: Bool?
    @Binding var codeInput: String
    
    var keyboardFocus: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .frame(width: 50, height: 60)
            .overlay {
                TextField("", text: $codeInput)
                    .focused($isFocused, equals: true)
                    .padding()
                    .offset(x: 4)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 3)
            )
            .onTapGesture {
                isFocused = true
            }
            .onAppear {
                if keyboardFocus {
                    isFocused = true
                }
            }
    }
}

#Preview {
    CodeInputView(codeInput: .constant(""), keyboardFocus: false)
}
