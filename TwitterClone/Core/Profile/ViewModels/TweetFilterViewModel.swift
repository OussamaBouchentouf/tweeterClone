//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .likes:
            return "Likes"
        case .replies:
            return "Replies"
        }
    }
}
