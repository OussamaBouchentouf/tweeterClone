//
//  ContentView.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showMenu: Bool = false
    
    var body: some View {
        Group {
            // No user logged in
            if viewModel.userSession == nil {
                LoginView()
            } else {
                mainInterfaceView
            }
        }
        
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(showMenu ? true : false)
            
            if showMenu {
                ZStack {
                    Color.black.opacity(showMenu ? 0.45 : 0)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300)
                .background(.clear)
        }
        .onAppear(perform: {
            self.showMenu = false
        })
        .navigationBarTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.easeInOut) {
                        self.showMenu.toggle()
                    }
                } label: {
                    if let user = viewModel.currentUser {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 42, height: 42)
                    }
                }
            }
        }
    }
}
