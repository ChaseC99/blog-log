//
//  ReadingView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/17/25.
//

import SwiftUI
import SwiftData

struct ReadingView: View {
    var reading: Reading
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false
    
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
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Edit", action: {
                    isEditing = true
                })
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            AddView(dismiss: {isEditing = false}, viewModel: AddView.ViewModel(reading: reading))
        }
        .alert("Delete Reading?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                modelContext.delete(reading)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .padding()
    }
}

#Preview {
    ReadingView(reading: MockData.reading())
}
