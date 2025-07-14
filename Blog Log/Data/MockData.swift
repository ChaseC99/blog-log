//
//  MockData.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/16/25.
//

import Foundation
import SwiftData

struct MockData {
    static func reading() -> Reading {
        let reading = Reading(timestamp: Date())
        reading.title = "Example Blog"
        reading.url = URL(string: "https://www.example.com/blog")
        reading.notes = "What a great blog post"
        
        return reading
    }
    
    static func readings() -> [Reading] {
        return [
            reading(),
            Reading(
                timestamp: Date().addingTimeInterval(-86400), // 1 day ago
                url: URL(string: "https://www.apple.com/newsroom"),
                title: "Apple's Latest Updates",
                notes: "Interesting insights about Apple's new features and updates."
            ),
            Reading(
                timestamp: Date().addingTimeInterval(-172800), // 2 days ago
                url: URL(string: "https://developer.apple.com/news"),
                title: "iOS Development Tips",
                notes: "Great tips for improving iOS app development workflow."
            )
        ]
    }
    
    @MainActor
    static func previewContainer() -> ModelContainer {
        let container = try! ModelContainer(for: Reading.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for reading in readings() {
            container.mainContext.insert(reading)
        }
        
        return container
    }
}
