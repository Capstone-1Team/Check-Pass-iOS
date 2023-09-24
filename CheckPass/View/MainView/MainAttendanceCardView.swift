//
//  MainAttendanceCardView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/17.
//

import SwiftUI

struct MainAttendanceCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var colorFrom: Color
    var colorTo: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [colorFrom, colorTo]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.3)
                .shadow(radius: 3)
            
//            HStack {
//                Spacer()
//                
//                image
//            }
//            .padding(.trailing)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                    
                    Text("출석하기")
                }
                
                Spacer()
            }
            .font(.title3)
            .bold()
            .foregroundColor(.white)
            .padding(.leading)
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Image(systemName: "arrow.forward.circle")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                        .foregroundColor(.white)
                }
            }
            .padding([.trailing, .bottom])
        }
    }
}

struct MainAttendanceCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainAttendanceCardView(title: "비콘", colorFrom: .blue, colorTo: Color(red: 129 / 255, green: 39 / 255, blue: 228 / 255))
    }
}
