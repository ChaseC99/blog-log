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
            HStack {
                if let image = reading.image, let uiImage = UIImage(data: image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                        .clipped()
                } else {
                    Image(systemName: "doc.plaintext")
                        .resizable()
                        .padding(5)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
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
            }
            Spacer()
        }
    }
}

#Preview {
    ReadingCard(reading: MockData.reading())
}
