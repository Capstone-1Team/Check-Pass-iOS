//
//  UserNumberInputView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/19.
//

import SwiftUI

struct UserNumberInputView: View {
    @Binding var idInput: String
    
    var body: some View {
        VStack(alignment: .leading) {            
            Text("학번 / 교직원 번호")
                .bold()
                .font(.title2)
            
            HStack {
                Image(systemName: "graduationcap")
                
                TextField("학번 또는 교직원 번호를 입력하세요.", text: $idInput)
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

struct UserNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserNumberInputView(idInput: .constant(""))
    }
}
