//
//  CurrentUserProfileViewModel.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import Foundation

final class CurrentUserPageViewModel: ObservableObject {
    
    let userManager: UserManager
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: current user page view model...")
        self.userManager = manager
    }
    
    func fetchUserPointless() -> String {
        return userManager.user
    }
    
}
