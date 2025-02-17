//
//  AddView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import LinkPresentation

struct AddView: View {
    var dismiss: () -> Void
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ViewModel()
    
    func fetchMetadata() {
        // Metadata fetching logic
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // URL Input Field
                TextField("URL", text: $viewModel.url, onCommit: fetchMetadata)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                
                // Title Input Field
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if viewModel.isLoadingMetaData {
                    ProgressView("Loading...")
                }
                
                // Date Field
                DatePicker("Read on", selection: $viewModel.timestamp)
                
                
                // Notes Input Field
                TextEditor(text: $viewModel.notes)
                    .frame(height: 150)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.addReading(to: modelContext)
                        dismiss()
                    }) {
                        Text("Log")
                    }
                }
            }
        }
        
    }
}

#Preview {
    AddView(dismiss: {})
}
