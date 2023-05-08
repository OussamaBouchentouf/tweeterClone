//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 5/5/2023.
//

import SwiftUI

class UploadTweetViewModel: ObservableObject {
    
    @Published var didUploadTweet: Bool = false
    
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.updateTweet(caption: caption) { success in
            if success {
                self.didUploadTweet = true
            } else {
                // Show error message to the user...
            }
        }
    }
}
