//
//  NGHTLFEApp.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI
import Firebase

@main
struct NGHTLFEApp: App {
    @StateObject var userManager = UserManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userManager)
        }
    }
}
