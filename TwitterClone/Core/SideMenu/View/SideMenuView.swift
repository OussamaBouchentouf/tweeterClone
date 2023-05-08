//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 68, height: 68)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text("@\(user.username )")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    UserStatsView()
                        .padding(.vertical)
                }
                .padding(.leading)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                    
                    if option == .profile {
                        NavigationLink { ProfileView(user: user) }
                    label: { SideMenuOptionRowView(option: option) }
                    } else if option == .logout {
                        Button { viewModel.signOut() }
                    label: { SideMenuOptionRowView(option: option) }
                    } else { SideMenuOptionRowView(option: option) }
                }
                .padding(.vertical, 4)
                
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.top)
            .background(.white)
        }
    }
}

