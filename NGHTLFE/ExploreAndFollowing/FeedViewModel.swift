//
//  FeedViewModel.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import Foundation

final class FeedViewModel: ObservableObject {
    
    let userManager: UserManager
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: feed view model...")
        self.userManager = manager
    }
    
    func fetchUserPointless() -> String {
        return userManager.user
    }
}
