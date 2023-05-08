//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {

    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var caption: String = ""
    
    @ObservedObject var updateTweetViewModel = UploadTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    updateTweetViewModel.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .foregroundColor(.white)
                        .background(Color(!caption.isEmpty ? .systemBlue : .systemGray))
                        .cornerRadius(25)
                }
                .disabled(caption.isEmpty)
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = viewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    
                    TextArea("What's happening?", text: $caption)
                }
            }
            .padding()
        }
        .onReceive(updateTweetViewModel.$didUploadTweet) { success in
            if success {
                dismiss()
            }
        }
    }
}
