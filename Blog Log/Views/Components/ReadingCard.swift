//
//  ReadingCard.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/16/25.
//

import SwiftUI

struct ReadingCard: View {
    var reading: Reading
    
    func fetchMetadata() {
        // Metadata fetching logic
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                if let title = reading.title {
                    Text(title)
                        .font(.title2)
                        .bold()
                }
                if let url = reading.url?.absoluteString {
                    Text(url)
                        .font(.callout)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ReadingCard(reading: MockData.reading())
}
