//
//  NGHTLFEApp.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import SwiftUI

@main
struct NGHTLFEApp: App {
    @StateObject var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userManager)
        }
    }
}
