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
        var id: UUID?
        var timestamp: Date
        var title: String
        var url: String
        var notes: String
        var modelContext: ModelContext
        
        init(isLoadingMetaData: Bool = false, id: UUID? = nil, timestamp: Date = Date(), title: String = "", url: String = "", notes: String = "") {
            self.isLoadingMetaData = isLoadingMetaData
            self.id = id
            self.timestamp = timestamp
            self.title = title
            self.url = url
            self.notes = notes
            
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
        
        func addReading() {
            let title: String? = self.title.isEmpty ? nil : self.title
            let notes: String? = self.notes.isEmpty ? nil : self.notes

            let newReading = Reading(
                timestamp: self.timestamp,
                url: URL(string: self.url),
                title: title,
                notes: notes
            )
            modelContext.insert(newReading)
            do {
                try modelContext.save()
            } catch {
                print("Error saving reading: \(error)")
            }
        }
    }
}
 
