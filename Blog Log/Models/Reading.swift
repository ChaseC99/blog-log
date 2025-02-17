//
//  Reading.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import Foundation
import SwiftData

@Model
final class Reading {
    var timestamp: Date
    var url: URL?
    var title: String?
    var notes: String?
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
