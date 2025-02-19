//
//  AddView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import LinkPresentation
import SwiftData
import UniformTypeIdentifiers

struct AddView: View {
    var dismiss: () -> Void
    
    @State private var viewModel: ViewModel
    
    init(dismiss: @escaping () -> Void, viewModel: ViewModel = ViewModel()) {
        self.dismiss = dismiss
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // URL Input Field
                HStack {
                    TextField("URL", text: $viewModel.url, onCommit: viewModel.fetchMetaData)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                    
                    PasteButton(payloadType: String.self) { items in
                        guard let text = items.first else { return }
                        viewModel.url = text
                        viewModel.fetchMetaData()
                    }
                }
                
                if viewModel.isLoadingMetaData {
                    // Show loading indicator when metadata is loading
                    ProgressView("Loading...")
                } else {
                    // Show error message if metadata fails to load
                    if viewModel.errorLoadingMetaData {
                        Text("Unable to load metadata, but you can still enter it on your own.")
                            .font(.caption)
                    }
                    
                    HStack(alignment: .center) {
                        // Preview Image
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                        }
                        
                        // Title Input Field
                        TextField("Title", text: $viewModel.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                // Notes Input Field
                TextInput(placeholder: "Note", text: $viewModel.notes)
                
                // Date Field
                DatePicker("Read on", selection: $viewModel.timestamp)
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
