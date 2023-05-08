//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 5/5/2023.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    let service = TweetService()
    let userService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {        
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUID: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
