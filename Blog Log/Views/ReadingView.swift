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
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    // Placeholder for image
                    
                    // Title and URL
                    VStack(alignment: .leading) {
                        Text(reading.title ?? "")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        
                        if let url = reading.url {
                            Link(destination: url) {
                                Text(url.absoluteString)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                
                Divider()
                
                Text("Read on \(reading.timestamp.formatted(date: .long, time: .shortened))")
                    .font(.footnote)
                
                Spacer(minLength: 16)
                
                Text(reading.notes ?? "")
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        isEditing = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis")
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
    }
}

#Preview {
    ReadingView(reading: MockData.reading())
}
