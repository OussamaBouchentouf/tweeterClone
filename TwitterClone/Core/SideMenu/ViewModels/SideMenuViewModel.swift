//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case lists
    case bookmarks
    case logout
    
    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .bookmarks:
            return "Bookmarks"
        case .lists:
            return "Lists"
        case .logout:
            return "Logout"
        }
    }
        
    var imageName: String {
        switch self {
        case .profile:
            return "person"
        case .bookmarks:
            return "bookmark"
        case .lists:
            return "list.bullet"
        case .logout:
            return "arrow.left.square"
        }
    }
}
