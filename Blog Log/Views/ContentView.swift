//
//  ContentView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Reading.timestamp, order: .reverse) private var readings: [Reading]

    @State private var isPresentingAddView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(readings) { reading in
                    NavigationLink {
                        ReadingView(reading: reading)
                    } label: {
                        ReadingCard(reading: reading)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Reading", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingAddView) {
            AddView(dismiss: {isPresentingAddView = false})
        }
    }

    private func addItem() {
        withAnimation {
            isPresentingAddView = true
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(readings[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(MockData.previewContainer())
}
