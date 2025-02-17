//
//  ReadingView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/17/25.
//

import SwiftUI

struct ReadingView: View {
    var reading: Reading
    
    var body: some View {
        VStack {
            Text(reading.title ?? "")
                .font(.largeTitle)
                .padding()
            Text(reading.url?.absoluteString ?? "")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding()
            Text(reading.notes ?? "")
                .font(.body)
                .padding()
            
            Text("Read on: \(reading.timestamp.formatted())")
        }
    }
}

#Preview {
    ReadingView(reading: MockData.reading())
}
