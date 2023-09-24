//
//  UserTypeSelectionView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/19.
//

import SwiftUI

struct UserTypeSelectionView: View {
    @Binding var selectedUserType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("구분")
                .bold()
                .font(.title2)
            
            HStack {
                UserTypePicker(selectedUserType: $selectedUserType, type: "학생")
                
                UserTypePicker(selectedUserType: $selectedUserType, type: "교수")
                
                UserTypePicker(selectedUserType: $selectedUserType, type: "교직원")
            }
        }
    }
}

struct UserTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionView(selectedUserType: .constant(""))
    }
}
