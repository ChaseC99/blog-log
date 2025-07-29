//
//  ContentExtractor.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 7/28/25.
//

import Foundation
import SwiftSoup

class ContentExtractor {
    static let shared = ContentExtractor()
    
    private init() {}
    
    func extractContent(from url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8) else {
                completion(.failure(ContentExtractorError.invalidData))
                return
            }
            
            let extractedContent = self.extractReadableContent(from: html)
            completion(.success(extractedContent))
        }
        
        task.resume()
    }
    
    private func extractReadableContent(from html: String) -> String {
        do {
            let document = try SwiftSoup.parse(html)
            let text = try document.text()
            
            return text
            
        } catch {
            print("Unable to parse HTML: \(error)")
        }
        
        return ""
    }
}

enum ContentExtractorError: Error, LocalizedError {
    case invalidData
    case parsingError
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data received from URL"
        case .parsingError:
            return "Error parsing content"
        }
    }
}
