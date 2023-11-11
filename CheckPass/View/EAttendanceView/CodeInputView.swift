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
    
    var placeholder: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $codeInput)
                .focused($isFocused, equals: true)
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 1)
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    CodeInputView(codeInput: .constant(""), placeholder: "")
}
