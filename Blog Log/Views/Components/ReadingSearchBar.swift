import SwiftUI

struct ReadingSearchBar: View {
    @Binding var searchText: String
    var hostSuggestions: [String]
    @FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        VStack {
            HStack {
                TextField("Search by title or url", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .focused($isSearchFieldFocused)
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        isSearchFieldFocused = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .accessibilityLabel("Clear search text")
                    }
                    .padding(.trailing)
                }
            }
            if !hostSuggestions.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(hostSuggestions, id: \.self) { host in
                            Button(action: {
                                searchText = host
                                isSearchFieldFocused = false
                            }) {
                                Text(host)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
        }.padding(.top)
    }
}
