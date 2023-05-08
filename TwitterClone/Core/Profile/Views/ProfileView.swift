//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var feedViewModel = FeedViewModel()
    
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    
    @Namespace var animation

    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                }
                .padding(.leading)
                .offset(y: 12)
                
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 90, height: 90)
                    .offset(x: 16, y: 25)
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle()
                    .stroke(.gray, lineWidth: 0.75))
            
            Button {
                 // NO action
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 120, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 0.75))
            }

        }
        .padding(.top)
        .padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(viewModel.user.fullname)
                    .font(.title2)
                    .bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
                
            }
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Here it's a sentence to fill the profile")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 28) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Oujda, MA")
                }
                
                HStack {
                    Image(systemName: "link")
                    
                    Text("www.swiftIOS.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            UserStatsView()
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item
                                    ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item
                                         ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "animation", in: animation)
                            
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(alignment: .center) {
            Divider()
                .offset(x: 0, y: 16)
        }
    }
    
    var tweetsView: some View {
        ScrollView {
            if viewModel.tweets.isEmpty {
                Spacer()
                VStack {
                    Text("You don't have post any tweets yet! :D")
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.heavy)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                LazyVStack(alignment: .center) {
                    ForEach(viewModel.tweet(forFilter: self.selectedFilter)) { tweet in
                        TweetRowView(tweet: tweet)
                            .padding()
                    }
                }
            }
        }
        .disabled(viewModel.tweets.isEmpty)
        .refreshable {
            feedViewModel.fetchTweets()
            viewModel.fetchLikedTweets()
        }
        .onChange(of: self.selectedFilter) { _ in
            feedViewModel.fetchTweets()
            viewModel.fetchLikedTweets()
        }
    }
}

