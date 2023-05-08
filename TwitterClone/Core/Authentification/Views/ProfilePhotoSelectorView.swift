//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var profileImage: Image? = nil
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title1: "Setup your account", title2: "Add a profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())

                } else {
                    Image("add_photo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .padding(.all)
                        .background(.gray.opacity(0.4))
                        .cornerRadius(200)
                }
            }
            .padding(.top, 44)
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                RoundedButton(text: "Continue") {
                    viewModel.uploadProfileImage(selectedImage)
                }
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
