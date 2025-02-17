//
//  AddViewModel.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import Foundation
import SwiftData

extension AddView {
    @Observable
    class ViewModel {
        // State
        var isLoadingMetaData = false
        
        // Content
        var timestamp: Date = Date()
        var title: String = ""
        var url: String = ""
        var notes: String = ""
        
        
        func addReading(to modelContext: ModelContext) {
            let newReading = Reading(timestamp: Date())
            newReading.url = URL(string: url)
            newReading.title = title
            newReading.notes = notes
            modelContext.insert(newReading)
            do {
                try modelContext.save()
            } catch {
                print("Error saving reading: \(error)")
            }
        }
    }
}
 
