//
//  MainView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/13.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    var body: some View {
        Text("로그인한 유저 uid : \(Auth.auth().currentUser?.uid ?? "")")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
