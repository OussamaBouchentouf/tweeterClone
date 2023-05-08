//
//  TextArea.swift
//  TwitterClone
//
//  Created by Robotics on 28/4/2023.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var text: String
    
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        TextEditor(text: $text)
            .padding(5)
            .overlay(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 14)
                }
            }
            .font(.body)
    }
}
