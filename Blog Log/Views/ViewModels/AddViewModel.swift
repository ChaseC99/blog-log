//
//  AddViewModel.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import Foundation
import SwiftData
import LinkPresentation

extension AddView {
    @Observable
    class ViewModel {
        // State
        var isLoadingMetaData = false
        
        // Content
        var existingReading: Reading?
        var timestamp: Date
        var title: String
        var url: String
        var notes: String
        var modelContext: ModelContext
        
        init(isLoadingMetaData: Bool = false, timestamp: Date = Date(), title: String = "", url: String = "", notes: String = "") {
            self.isLoadingMetaData = isLoadingMetaData
            self.timestamp = timestamp
            self.title = title
            self.url = url
            self.notes = notes
            
            self.existingReading = nil
            self.modelContext = ModelContext(ModelContainerProvider.shared)
        }
        
        init(reading: Reading) {
            self.timestamp = reading.timestamp
            self.title = reading.title ?? ""
            self.url = reading.url?.absoluteString ?? ""
            self.notes = reading.notes ?? ""
            
            self.existingReading = reading
            self.modelContext = ModelContext(ModelContainerProvider.shared)
        }

        
        func fetchMetaData() {
            isLoadingMetaData = true
            let metadataProvider = LPMetadataProvider()
            if let url = URL(string: self.url) {
                metadataProvider.startFetchingMetadata(for: url) { metadata, error in
                    if let metadata = metadata {
                        DispatchQueue.main.async {
                            self.title = metadata.title ?? ""
                            self.isLoadingMetaData = false
                        }
                    }
                }
            }
        }
        
        func saveReading() {
            let title: String? = self.title.isEmpty ? nil : self.title
            let notes: String? = self.notes.isEmpty ? nil : self.notes

            if let existingReading = self.existingReading {
                // Update existing reading
                existingReading.timestamp = self.timestamp
                existingReading.url = URL(string: self.url)
                existingReading.title = title
                existingReading.notes = notes
            } else {
                // Create new reading
                let newReading = Reading(
                    timestamp: self.timestamp,
                    url: URL(string: self.url),
                    title: title,
                    notes: notes
                )
                modelContext.insert(newReading)
            }

            // Save the context
            do {
                try modelContext.save()
            } catch {
                print("Error saving reading: \(error)")
            }
        }
    }
}
 
