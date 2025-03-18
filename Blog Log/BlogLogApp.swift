//
//  Blog_LogApp.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import SwiftData

@main
struct Blog_LogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ModelContainerProvider.shared)
    }
}
