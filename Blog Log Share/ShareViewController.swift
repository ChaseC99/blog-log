//
//  ShareViewController.swift
//  Blog Log Share
//
//  Created by Chase Carnaroli on 2/17/25.
//

import UIKit
import Social
import SwiftUI
import SwiftData

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let viewModel = AddView.ViewModel()
        
        // Get the URL from the webpage
        if let item = self.extensionContext?.inputItems.first as? NSExtensionItem,
           let attachments = item.attachments {
            for attachment in attachments {
                if attachment.hasItemConformingToTypeIdentifier("public.url") {
                    attachment.loadItem(forTypeIdentifier: "public.url", options: nil) { (url, error) in
                        if let url = url as? URL {
                            // Handle the URL (e.g., save it to a model context)
                            print("URL: \(url)")
                            viewModel.url = url.absoluteString
                            viewModel.fetchMetaData()
                        }
                    }
                }
            }
        }
        
        // Setup a SwiftUI view
        let modelContext = ModelContext(ModelContainerProvider.shared)
        let contentView = UIHostingController(rootView: AddView(modelContext: modelContext, dismiss: self.close, viewModel: viewModel))
        self.addChild(contentView)
        self.view.addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
        
        // Add listener for the close event
        NotificationCenter.default.addObserver(forName: NSNotification.Name("close"), object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.close()
            }
       }
    }
    
    /// Close the Share Extension
    func close() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
