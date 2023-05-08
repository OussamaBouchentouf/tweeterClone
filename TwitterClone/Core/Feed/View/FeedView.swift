//
//  FeedView.swift
//  TwitterClone
//
//  Created by Robotics on 16/4/2023.
//

import SwiftUI
import Firebase

struct FeedView: View {
    
    @State private var showNewTweetView: Bool = false
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        TweetRowView(tweet: tweet)
                    }
                }
            }
            .refreshable {
                viewModel.fetchTweets()
            }
            
            Button {
                self.showNewTweetView.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .scaledToFill()
                    .padding()
                    .shadow(color: .black, radius: 25)
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewTweetView) {
                NewTweetView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
