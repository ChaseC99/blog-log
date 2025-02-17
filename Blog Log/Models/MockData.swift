//
//  MockData.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/16/25.
//

import Foundation

struct MockData {
    static func reading() -> Reading {
        let reading = Reading(timestamp: Date())
        reading.title = "Example Blog"
        reading.url = URL(string: "www.example.com/blog")
        reading.notes = "What a great blog post"
        
        return reading
    }
}
