//
//  User.swift
//  TwitterClone
//
//  Created by Robotics on 4/5/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
