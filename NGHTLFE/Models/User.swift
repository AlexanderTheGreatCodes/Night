//
//  User.swift
//  NightLife
//
//  Created by Michael Neibauer on 8/1/24.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    
    let id: String
    let email: String
    
    var name: String?
    var bio: String?
    var profileImage: String?
    
    var usersYouFollow: Set<String>
    var followers: Set<String>
    
    init(id: String, email: String, name: String? = nil, bio: String? = nil, profileImage: String? = nil, usersYouFollow: Set<String>, followers: Set<String>) {
        self.id = id
        self.email = email
        self.name = name
        self.bio = bio
        //maybe bio as well...
        self.profileImage = nil
        self.usersYouFollow = []
        self.followers = []
    }
}
