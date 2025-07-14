import Foundation
import SwiftUI
import SwiftData

extension ContentView {
    @Observable
    class ViewModel {
        var filteredReadings: [Reading] = []
        var hostSuggestions: [String] = []
        var isPresentingAddView = false
        var readings: [Reading] = [] {
            didSet { updateFiltered() }
        }
        var searchText: String = "" {
            didSet {
                updateFiltered()
            }
        }
        
        func updateFiltered() {
            if searchText.isEmpty {
                filteredReadings = readings
            } else {
                filteredReadings = readings.filter { reading in
                    let titleMatch = reading.title?.localizedCaseInsensitiveContains(searchText) ?? false
                    let urlMatch = reading.url?.absoluteString.localizedCaseInsensitiveContains(searchText) ?? false
                    return titleMatch || urlMatch
                }
            }
            updateHostSuggestions()
        }
        
        func updateHostSuggestions() {
            let hosts = readings.compactMap { reading -> String? in
                guard let url = reading.url else { return nil }
                return url.host
            }
            let uniqueHosts = Set(hosts)
            hostSuggestions = uniqueHosts.filter { !searchText.isEmpty && $0.localizedCaseInsensitiveContains(searchText) && $0 != searchText }
        }

    }
}
