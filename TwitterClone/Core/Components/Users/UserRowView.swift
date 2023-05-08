//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 58, height: 58)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(user.username)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .bold()
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
