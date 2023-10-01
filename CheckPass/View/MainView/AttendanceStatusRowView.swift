//
//  AttendanceStatusRowView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/24.
//

import SwiftUI

struct AttendanceStatusRowView: View {
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
            }
            
            HStack {
                Text("출석: 0")
                
                Spacer()
                
                Text("결석: 0")
                
                Spacer()
                
                Text("지각: 0")
            }
        }
    }
}

#Preview {
    AttendanceStatusRowView(title: "소프트웨어공학")
}
