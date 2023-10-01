//
//  MainTabView.swift
//  CheckPass
//
//  Created by 이정훈 on 2023/09/05.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    
                    Text("홈")
                }
            
            LectureListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    
                    Text("강의")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    
                    Text("검색")
                }
            
            SettingView()
                .environmentObject(authViewModel)
                .tabItem {
                    Image(systemName: "ellipsis")
                    
                    Text("더보기")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
    }
}
