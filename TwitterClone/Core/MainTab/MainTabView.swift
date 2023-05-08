//
//  MainTabView.swift
//  TwitterClone
//
//  Created by Robotics on 27/4/2023.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onTapGesture { self.selectedIndex = 0 }
                .tabItem { Image(systemName: "house") }
                .tag(0)
            
            ExploreView()
                .onTapGesture { self.selectedIndex = 0 }
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
                .navigationTitle("Explore")
            
            NotificationsView()
                .onTapGesture { self.selectedIndex = 0 }
                .tabItem { Image(systemName: "bell") }
                .tag(2)
                .navigationTitle("Notification")
            
            MessagesView()
                .onTapGesture { self.selectedIndex = 0 }
                .tabItem { Image(systemName: "envelope") }
                .tag(3)
                .navigationTitle("Messages")
        }
    }
}
