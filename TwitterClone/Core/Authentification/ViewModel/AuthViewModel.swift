//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser: Bool = false
    @Published var currentUser: User?
    
    // For Better UX isLoading for buttons and Error to diplay errors:
    @Published var isLoading: Bool = false
    @Published var error: String = ""
    
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        self.error = ""
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error.localizedDescription
                self.isLoading = false
                return
            }
            
            guard let user = result?.user else {
                self.isLoading = false
                return
            }
            self.userSession = user
            self.fetchUser()
            self.isLoading = false
        }
    }
    
    func signOut() {
        // Set userSession to nil, so we show login page
        self.userSession = nil
        
        // Signs user out on server
        try? Auth.auth().signOut()
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        self.error = ""
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error.localizedDescription
                self.isLoading = false
                return
            }
            
            guard let user = result?.user else {
                self.isLoading = false
                return
            }
            
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    withAnimation(.easeInOut) {
                        self.didAuthenticateUser = true
                    }
                }
            
            self.isLoading = false
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        self.error = ""
        self.isLoading = true
        
        guard let uid = tempUserSession?.uid else {
            self.isLoading = false
            return
        }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl" : profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
        
        self.isLoading = false
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUID: uid) { user in
            self.currentUser = user
        }
    }
}

