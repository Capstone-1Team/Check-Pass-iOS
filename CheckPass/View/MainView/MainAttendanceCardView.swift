//
//  MainAttendanceCardView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/17.
//

import SwiftUI

struct MainAttendanceCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    //var backgroundColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.width * 0.3)
            .foregroundColor(colorScheme == .light ? .white : Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255))
            .shadow(radius: 3)
    }
}

struct MainAttendanceCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainAttendanceCardView()
    }
}
