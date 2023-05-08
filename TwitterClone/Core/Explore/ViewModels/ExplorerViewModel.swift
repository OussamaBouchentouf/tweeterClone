//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 4/5/2023.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText: String = ""
    
    var searchableUsers: [User] {
        if self.searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
}
