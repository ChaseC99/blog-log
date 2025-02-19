//
//  TextInput.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/19/25.
//

import SwiftUI

struct TextInput: View {
    var placeholder: String?
    
    @Binding var text: String

    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray5))
                    )
                .font(.body)
            if text.isEmpty {
                Text(placeholder ?? "")
                    .foregroundColor(Color(.placeholderText))
                    .font(.body)
                    .padding([.leading], 5+3)
                    .padding([.top], 5+8)
                
            }
        }
    }
}

#Preview {
    TextInput(placeholder: "Note", text: .constant(""))
}
