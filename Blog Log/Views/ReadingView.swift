//
//  ReadingView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/17/25.
//

import SwiftUI

struct ReadingView: View {
    var reading: Reading
    
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Text(reading.title ?? "")
                .font(.largeTitle)
                .padding()
            
            if let url = reading.url {
                Link(url.absoluteString, destination: url)
            }
            
            Text(reading.notes ?? "")
                .font(.body)
                .padding()
            
            Text("Read on: \(reading.timestamp.formatted())")
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit", action: {
                    isEditing = true
                })
            }
        }
        .sheet(isPresented: $isEditing) {
            AddView(dismiss: {isEditing = false}, viewModel: AddView.ViewModel(reading: reading))
        }
        .padding()
    }
}

#Preview {
    ReadingView(reading: MockData.reading())
}
