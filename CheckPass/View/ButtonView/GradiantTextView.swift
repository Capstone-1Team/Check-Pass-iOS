//
//  GradiantTextView.swift
//  CheckPass
//
//  Created by 이정훈 on 11/4/23.
//

import SwiftUI

struct GradiantTextView: View {
    var label: String
    var startColor: Color
    var endColor: Color
    
    var body: some View {
        Text(label)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(30)
    }
}

#Preview {
    GradiantTextView(label: "출석하기", startColor: .blue, endColor: Color(red: 93 / 255, green: 50 / 255, blue: 229 / 255))
}
