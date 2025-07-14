//
//  ContentView.swift
//  Blog Log
//
//  Created by Chase Carnaroli on 2/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Reading.timestamp, order: .reverse) private var readings: [Reading]

    @State private var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Main List View
                VStack {
                    ReadingSearchBar(
                        searchText: $viewModel.searchText,
                        hostSuggestions: viewModel.hostSuggestions
                    )
                    List {
                        ForEach(viewModel.filteredReadings) { reading in
                            NavigationLink {
                                ReadingView(reading: reading)
                            } label: {
                                ReadingCard(reading: reading)
                            }
                        }
                    }
                    .listStyle(.plain)
                }

                // Floating Add Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: addItem) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresentingAddView) {
            AddView(dismiss: {viewModel.isPresentingAddView = false})
        }
        .onAppear {
            viewModel.readings = readings
        }
        .onChange(of: readings) { _, newReadings in
            viewModel.readings = newReadings
        }
    }

    private func addItem() {
        withAnimation {
            viewModel.isPresentingAddView = true
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(MockData.previewContainer())
}
