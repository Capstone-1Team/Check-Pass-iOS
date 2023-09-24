//
//  AttendanceStatusView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/24.
//

import SwiftUI

struct AttendanceStatusView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(colorScheme == .light ? .white : Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255))
                .shadow(radius: 3)
            
            VStack(alignment: .leading) {
                Text("출결 현황")
                    .bold()
                    .font(.title2)
                    .padding(.bottom)
                
                AttendanceStatusRowView(title: "소프트웨어공학")
                
                Divider()
                    .padding(.bottom)
                
                AttendanceStatusRowView(title: "캡스톤디자인1")
            }
            .padding()
        }
    }
}

#Preview {
    AttendanceStatusView()
}
