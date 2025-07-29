//
//  TextInput.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/19/25.
//

import SwiftUI

struct TextInput: View {
    var placeholder: String?
    var blogContent: String = ""
    
    @Binding var text: String
    
    // State for autocomplete
    @State private var showAutocomplete = false
    @State private var filteredQuotes: [String] = []
    @State private var quoteQuery: String = ""
    @FocusState private var isFocused: Bool
    
    // Helper: Detect '>' at start of a line and extract query
    private func updateAutocomplete() {
        // Find the last line in the text
        let lines = text.components(separatedBy: "\n")
        guard let lastLine = lines.last else {
            showAutocomplete = false
            filteredQuotes = []
            return
        }
        let trimmedLine = lastLine.trimmingCharacters(in: .whitespaces)
        // Check if line starts with '>'
        if trimmedLine.hasPrefix(">") {
            let query = trimmedLine.dropFirst().trimmingCharacters(in: .whitespaces)
            quoteQuery = query
            if !query.isEmpty {
                // Build regex pattern to match sentences containing the query (partial match)
                let pattern = "[^.]*" + NSRegularExpression.escapedPattern(for: query) + "[^.]*\\."
                let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
                var matches: [String] = []
                if let regex = regex {
                    let range = NSRange(blogContent.startIndex..<blogContent.endIndex, in: blogContent)
                    let results = regex.matches(in: blogContent, options: [], range: range)
                    for result in results {
                        if let matchRange = Range(result.range, in: blogContent) {
                            let match = String(blogContent[matchRange]).trimmingCharacters(in: .whitespacesAndNewlines)
                            matches.append(match)
                        }
                    }
                }
                filteredQuotes = matches
                showAutocomplete = !filteredQuotes.isEmpty
            } else {
                filteredQuotes = []
                showAutocomplete = false
            }
        } else {
            showAutocomplete = false
            filteredQuotes = []
        }
    }
    // Helper: Replace '> query' with selected quote
    private func insertQuote(_ quote: String) {
        // Find the last line that starts with '>'
        let lines = text.components(separatedBy: "\n")
        if let lastIndex = lines.indices.last, lines[lastIndex].trimmingCharacters(in: .whitespaces).hasPrefix(">") {
            var newLines = lines
            newLines[lastIndex] = "> " + quote
            text = newLines.joined(separator: "\n")
        }
        showAutocomplete = false
        filteredQuotes = []
        quoteQuery = ""
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(UIColor.systemGray5))
                    )
                    .font(.body)
                    .onChange(of: text) { _, _ in
                        updateAutocomplete()
                    }
                if text.isEmpty {
                    Text(placeholder ?? "")
                        .foregroundColor(Color(.placeholderText))
                        .font(.body)
                        .padding([.leading], 5+3)
                        .padding([.top], 5+8)
                }
            }
            // Autocomplete dropdown
            if showAutocomplete {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                            ForEach(filteredQuotes, id: \.self) { quote in
                                Button(action: { insertQuote(quote) }) {
                                    Text(quote)
                                        .padding(8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                }
                                .background(Color(.systemGray6))
                                .foregroundColor(.primary)
                            }
                    }
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .padding(.horizontal, 5)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var previewText = ""
    let blogContent = "SwiftUI uses a declarative syntax, so you can simply state what your user interface should do. For example, you can write that you want a list of items consisting of text fields, then describe alignment, font, and color for each field. Your code is simpler and easier to read than ever before, saving you time and maintenance."
    return TextInput(placeholder: "Note", blogContent: blogContent, text: $previewText)
}
