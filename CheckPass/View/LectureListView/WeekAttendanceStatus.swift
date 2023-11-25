//
//  WeekAttendanceStatus.swift
//  CheckPass
//
//  Created by 이정훈 on 11/25/23.
//

import SwiftUI

struct WeekAttendanceStatus: View {
    var week: Int
    var isAttend: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.width * 0.09)
                .foregroundColor(isAttend ? .blue : .gray)
            
            Text("\(week)")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    WeekAttendanceStatus(week: 1, isAttend: false)
}
