//
//  RoundedButton.swift
//  TwitterClone
//
//  Created by Robotics on 3/5/2023.
//

import SwiftUI

struct RoundedButton: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    let text: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            } else {
                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
        }
        .shadow(color: .gray.opacity(0.7), radius: 25, x: 0, y: 0)
    }
}
