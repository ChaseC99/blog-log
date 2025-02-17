//
//  ModelContainerProvider.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/16/25.
//

import SwiftData

class ModelContainerProvider {
    static let shared: ModelContainer = {
        let schema = Schema([
            Reading.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
