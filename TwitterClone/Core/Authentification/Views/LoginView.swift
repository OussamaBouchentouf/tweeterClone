//
//  LoginView.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import SwiftUI
import Toast_Swift

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        // Parent container
        VStack {
            // Header view
            AuthenticationHeaderView(title1: "Hello.",
                                     title2: "Welcome Back")
            
            VStack(spacing: 40) {
                CustomInputField(text: $email,
                                 imageName: "envelope",
                                 placeholder: "Email")
                    .keyboardType(.emailAddress)
                
                CustomInputField(text: $password,
                                 imageName: "lock",
                                 placeholder: "Password",
                                 isSecureField: true)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                   // some navigation here....
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            RoundedButton(text: "Sing In") {
                viewModel.login(withEmail: email,
                                password: password)
            }
            
            Spacer()
            
            NavigationLink {
               RegistrationView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Don't have an account?")
                    .font(.footnote)
                    
                Text("Sign UP")
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))

        }
        .ignoresSafeArea()
        .onChange(of: viewModel.error) { val in
            if val != "" {
                ShowToast.shearedInstance.showToast(message: viewModel.error, backgroundColor: UIColor(.red), image: UIImage(systemName: "xmark.circle.fill"))
            }
        }
    }
}
