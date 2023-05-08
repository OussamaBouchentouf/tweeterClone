//
//  CustomInoutField.swift
//  TwitterClone
//
//  Created by Robotics on 2/5/2023.
//

import SwiftUI

struct CustomInputField: View {

    @Binding var text: String
    
    let imageName: String
    let placeholder: String
    
    var isSecureField: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}
