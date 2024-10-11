//
//  InboxViewModel.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import Foundation

final class InboxViewModel: ObservableObject {
    
    let userManager: UserManager
    
    init(manager: UserManager) {
        let _ = print("INIT STATUS: inbox view model...")
        self.userManager = manager
    }
    
    func fetchUserPointless() -> String {
        return userManager.user
    }
    
}
