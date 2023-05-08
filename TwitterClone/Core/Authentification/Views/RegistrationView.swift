//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var fullname: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        // Parent View
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: {})
            
            // Header view
            AuthenticationHeaderView(title1: "Get started.", title2: "Create your account")
            
            VStack(spacing: 30) {
                CustomInputField(text: $email,
                                 imageName: "envelope",
                                 placeholder: "Email")
                    .keyboardType(.emailAddress)
                
                CustomInputField(text: $username,
                                 imageName: "person",
                                 placeholder: "Username")
                
                CustomInputField(text: $fullname,
                                 imageName: "person",
                                 placeholder: "Fullname")
                
                CustomInputField(text: $password,
                                 imageName: "lock",
                                 placeholder: "Password",
                                 isSecureField: true)
            }
            .padding(22)
            
            RoundedButton(text: "Sign Up") {
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
            }
            
            Button {
               dismiss()
            } label: {
                Text("Already have an account?")
                    .font(.footnote)
                    
                Text("Sign IN")
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
            
            Spacer()
        }
        .ignoresSafeArea()
        .onChange(of: viewModel.error) { val in
            if val != "" {
                ShowToast.shearedInstance.showToast(message: viewModel.error, backgroundColor: UIColor(.red), image: UIImage(systemName: "xmark.circle.fill"))
            }
        }
    }
}
