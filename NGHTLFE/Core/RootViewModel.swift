//
//  RootViewModel.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/11/24.
//

//import Foundation
//import FirebaseAuth
//
//final class RootViewModel: ObservableObject {
//    
//    private let service = UserManager.shared
//    private var cancellables = Set<AnyCancellable>()
//    
//    @Published var userSession: FirebaseAuth.User?      //i don't like this here...
//    @Published var currentUser: User?
//    
//    init() {
//        setupSubscribers()
//    }
//    
//    //listens to changes in UserManager.currentUser ... (that's not a thing rn!?)
//    
//    func setupSubscribers() {
//        service.$userSession.sink { [weak self] userSession in
//            self?.userSession = userSession
//        }
//        .store(in: &cancellables)
//        
//        service.$currentUser.sink { [weak self] currentUser in
//            self?.currentUser = currentUser
//        }
//        .store(in: &cancellables)
//    }
//}
