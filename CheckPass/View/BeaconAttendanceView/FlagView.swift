//
//  FlagView.swift
//  CheckPass
//
//  Created by 이정훈 on 9/27/23.
//

import SwiftUI

struct FlagView: View {
    var body: some View {
        Image("FlagImage")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.53, height: UIScreen.main.bounds.width)
            .offset(y: -40)
    }
}

#Preview {
    FlagView()
}
