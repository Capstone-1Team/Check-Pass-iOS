//
//  UserNameInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/19.
//

import SwiftUI

struct UserNameInputView: View {
    @Binding var nameInput: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이름")
                .bold()
                .font(.title2)
            
            HStack {
                Image(systemName: "person")
                
                TextField("이름을 입력하세요.", text: $nameInput)
                    .font(.title3)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}

struct UserNameInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameInputView(nameInput: .constant(""))
    }
}
