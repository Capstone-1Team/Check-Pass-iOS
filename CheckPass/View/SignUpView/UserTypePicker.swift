//
//  UserTypePicker.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/18.
//

import SwiftUI

struct UserTypePicker: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedUserType: String
//    @Binding var showUserCategoryView: Bool
    
    var type: String
    
    var body: some View {        
        Button(action: {
            selectedUserType = type
        }, label: {
            Text(type)
                .padding()
                .foregroundColor(colorScheme == .light ? .black : .white)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedUserType == type ? .blue : Color(red: 182 / 255, green: 182 / 255, blue: 185 / 255), lineWidth: 2)
                }
        })
    }
}

struct UserTypePicker_Previews: PreviewProvider {
    static var previews: some View {
        UserTypePicker(selectedUserType: .constant("구분을 선택하세요."), type: "학생")
    }
}
