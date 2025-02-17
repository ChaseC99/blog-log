//
//  AddView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import LinkPresentation
import SwiftData

struct AddView: View {
    var modelContext: ModelContext
    var dismiss: () -> Void
    
    @State private var viewModel: ViewModel
    
    init(modelContext: ModelContext, dismiss: @escaping () -> Void, viewModel: ViewModel = ViewModel()) {
        self.modelContext = modelContext
        self.dismiss = dismiss
        self.viewModel = viewModel
    }
    
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
    AddView(modelContext: ModelContext(ModelContainerProvider.shared), dismiss: {})
}
