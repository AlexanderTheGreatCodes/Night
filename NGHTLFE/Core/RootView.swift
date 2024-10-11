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
        
        if userManager.userSession == nil {
            NavigationStack {
                LazyView { SignInView(manager: userManager) }
            }
        } else if let currentUser = userManager.currentUser {
            //if there is a user signed in, show main content...
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
                customizeTabBar()
            }

            
        }
     }
}

#Preview {
    RootView()
}
