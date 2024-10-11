//
//  ContentView.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var selectedTab = 1
    
    init() {
        let _ = print("INIT STATUS: root view...")
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            //lazy view is a util
            LazyView { InboxView(manager: userManager) }
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Chat")
                }
                .tag(0)
            
            LazyView { CurrentUserPageView(manager: userManager) }
                .tabItem {
                    Image(systemName: "moonphase.new.moon")
                    Text("Home")
                }
                .tag(1)
            
            LazyView { ExploreRoot() }
                .tabItem {
                    Image(systemName: "moon.haze.fill")
                    Text("Feed")
                }
                .tag(2)
        }
        .onAppear {
            let _ = print("APPEAR STATUS: root view...")
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.stackedLayoutAppearance.normal.iconColor = .white
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.nightLifeRed)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.nightLifeRed)]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    RootView()
}
