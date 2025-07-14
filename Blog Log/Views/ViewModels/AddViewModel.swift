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
        var errorLoadingMetaData = false
        
        // Content
        var existingReading: Reading?
        var timestamp: Date
        var title: String
        var url: String
        var notes: String
        var image: UIImage?
        var modelContext: ModelContext
        
        init(isLoadingMetaData: Bool = false, timestamp: Date = Date(), title: String = "", image: UIImage? = nil, url: String = "", notes: String = "") {
            self.isLoadingMetaData = isLoadingMetaData
            self.timestamp = timestamp
            self.title = title
            self.url = url
            self.notes = notes
            self.image = image
            
            self.existingReading = nil
            self.modelContext = ModelContext(ModelContainerProvider.shared)
        }
        
        init(reading: Reading) {
            self.timestamp = reading.timestamp
            self.title = reading.title ?? ""
            self.url = reading.url?.absoluteString ?? ""
            self.notes = reading.notes ?? ""
            if let data = reading.image, let image = UIImage(data: data) {
                self.image = image
            } else {
                self.image = nil
            }
            
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
                            // Use the rendered url, if possible, to get the actual URl after redirects
                            // example: open.substack.com/pub/slam -> slam.substack.com
                            self.url = metadata.url?.absoluteString ?? self.url
                            
                            // Get the title from metadata
                            self.title = metadata.title ?? ""
                            
                            if let imageProvider = metadata.imageProvider {
                                // Get the image from the website
                                imageProvider.loadObject(ofClass: UIImage.self) { image, error in
                                    DispatchQueue.main.async {
                                        if let image = image as? UIImage {
                                            self.image = image.resize(to: CGSize(width: 250, height: 250))
                                        }
                                    }
                                }
                            } else if let iconProvider = metadata.iconProvider {
                                // Fallback: Get the icon from the website
                                iconProvider.loadObject(ofClass: UIImage.self) { image, error in
                                    DispatchQueue.main.async {
                                        if let image = image as? UIImage {
                                            self.image = image.resize(to: CGSize(width: 250, height: 250))
                                        }
                                    }
                                }
                            }

                            self.errorLoadingMetaData = false
                            self.isLoadingMetaData = false
                        }
                    } else {
                        print("Error fetching metadata: \(error?.localizedDescription ?? "Unknown error")")
                        self.errorLoadingMetaData = true
                        self.isLoadingMetaData = false
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
                existingReading.image = self.image?.pngData()
                existingReading.notes = notes
            } else {
                // Create new reading
                let newReading = Reading(
                    timestamp: self.timestamp,
                    url: URL(string: self.url),
                    title: title,
                    image: self.image?.pngData(),
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
 
