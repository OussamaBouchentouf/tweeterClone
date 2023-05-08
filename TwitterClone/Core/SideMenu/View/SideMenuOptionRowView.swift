//
//  SideMenuOptionRowView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    
    let option: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: option.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(option.title)
                .foregroundColor(.black)
                .font(.subheadline)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}
