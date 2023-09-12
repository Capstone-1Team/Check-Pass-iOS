//
//  ProgressBarView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/08.
//

import SwiftUI

struct ProgressBarView: View {
    var page: Double
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(Int(page)) / 3")
                .foregroundColor(.gray)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 5)
                    .foregroundColor(.gray)
                
                if page < 3 {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: UIScreen.main.bounds.width * CGFloat((page / 3.0)), height: 5)
                        .foregroundColor(.accentColor)
                } else {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: .infinity)
                        .frame(height: 5)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(page: 3.0)
    }
}
