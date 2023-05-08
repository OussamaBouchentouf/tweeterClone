//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Robotics on 16/4/2023.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden(true)
            .environmentObject(viewModel)
        }
    }
}
