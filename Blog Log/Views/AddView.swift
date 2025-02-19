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
    var dismiss: () -> Void
    
    @State private var viewModel: ViewModel
    
    init(dismiss: @escaping () -> Void, viewModel: ViewModel = ViewModel()) {
        self.dismiss = dismiss
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // URL Input Field
                TextField("URL", text: $viewModel.url, onCommit: viewModel.fetchMetaData)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.URL)
                    .textInputAutocapitalization(.never)
                
                // Title Input Field
                if viewModel.isLoadingMetaData {
                    ProgressView("Loading...")
                } else {
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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
                        viewModel.saveReading()
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
