//
//  UserManager.swift
//  NGHTLFE
//
//  Created by Michael Neibauer on 10/8/24.
//

import FirebaseAuth
import FirebaseFirestore

final class UserManager: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    //test variable...
    let user: String = "Michael Neibauer"
    
    init() {
        let _ = print("INIT STATUS: user manager...")
        Task { try await loadUserData() }
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    func loadUserData() async throws {
        print("USER MANAGER DEBUG: loading user data...")
        //setting the user session...
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        UserManager.fetchUser(withUid: currentUid) { user in
            //setting the current user...
            self.currentUser = user
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else {
                return print ("USER MANAGER DEBUG: failed to fetch user...")
            }
            completion(user)
        }
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("USER MANAGER DEBUG: failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    func createUser(email: String, password: String, name: String?, bio: String?) async throws {
        print("USER MANAGER DEBUG: creating new user...")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("USER MANAGER DEBUG: ", result)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, email: email, name: name, bio: bio)
        } catch {
            print("USER MANAGER DEBUG: failed to register user with error \(error.localizedDescription)")
        }
    }
    
    func uploadUserData(uid: String, email: String, name: String?, bio: String?) async {
        print("USER MANAGER DEBUG: uploading user data to firestore...")
        let user = User(id: uid, email: email, name: name, bio: bio, profileImage: "", usersYouFollow: [], followers: [])
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
}
