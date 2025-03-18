//
//  AppDelegate.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 3/17/25.
//

import UIKit
import SwiftUICore

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    // Handle Quick Actions (shortcut items) when the app is in the foreground
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "feedback" {
            openFeedbackWebsite()
        }
    }
    
    // Handle Quick Actions when the app is launched from a shortcut item
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            if shortcutItem.type == "feedback" {
                openFeedbackWebsite()
            }
        }
    }
    
    func openFeedbackWebsite() {
        if let url = URL(string: "https://qrme.contact/contact") {
            UIApplication.shared.open(url)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = CustomSceneDelegate.self
             
        return sceneConfiguration
    }
}
