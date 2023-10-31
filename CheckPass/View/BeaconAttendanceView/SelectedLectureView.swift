//
//  SelectedLectureView.swift
//  CheckPass
//
//  Created by 이정훈 on 10/30/23.
//

import SwiftUI

struct SelectedLectureView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var scannedLecturesViewModel: ScannedLecturesViewModel
    
    var body: some View {
        ZStack {
            Color(red: 38 / 255, green: 38 / 255, blue: 40 / 255)
                .ignoresSafeArea()
            
            VStack {
                UserAttendanceCardView()
                    .environmentObject(scannedLecturesViewModel)
                    .environmentObject(userViewModel)
                    .padding([.leading, .trailing, .top])
                
                Image(systemName: "arrow.down")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 7)
                
                Button(action: {}, label: {
                    Text("출석하기")
                        .foregroundColor(.white)
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(30)
                })
                .padding([.leading, .trailing, .bottom])
            }
        }
    }
}

#Preview {
    SelectedLectureView()
        .environmentObject(ScannedLecturesViewModel())
        .environmentObject(UserViewModel())
}
