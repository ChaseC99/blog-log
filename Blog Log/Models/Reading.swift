//
//  Reading.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Reading {
    var timestamp: Date
    var url: URL?
    var image: Data?
    var title: String?
    var notes: String?
    
    init(timestamp: Date, url: URL? = nil, title: String? = nil, image: Data? = nil, notes: String? = nil) {
        self.timestamp = timestamp
        self.url = url
        self.title = title
        self.image = image
        self.notes = notes
    }
}
