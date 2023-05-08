//
//  UserStatsView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 28) {
            HStack(spacing: 4) {
                Text("1024")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
            }
            
            HStack(spacing: 4) {
                Text("12.8M")
                    .font(.subheadline)
                    .bold()
                
                Text("Followers")
                    .font(.caption)
            }
        }
    }
}
