//
//  NoLectureView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/9/23.
//

import SwiftUI

struct NoLectureView: View {
    var body: some View {
        VStack {
            Image("no_lecture")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.bottom)
            
            Text("앗...")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            Text("강의 리스트가 존재하지 않아요")
            
            Text("메인 화면 → 강의 탭에서 강의를 추가 해주세요")
        }
        .offset(y: -50)
        .foregroundColor(.gray)
    }
}

#Preview {
    NoLectureView()
}
