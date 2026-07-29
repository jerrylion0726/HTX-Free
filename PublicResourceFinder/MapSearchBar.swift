//
//  MapSearchBar.swift
//  PublicResourceFinder
//
//  The search field above the filter bar on the map screen,
//  plus the dropdown of matching results.
//

import SwiftUI

// MARK: - Search field

struct MapSearchBar: View {

    @Binding var searchText: String

    /// Lets the map dismiss the keyboard when a result is picked.
    @FocusState.Binding var isFocused: Bool

    var body: some View {
        HStack(spacing: 8) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search resources", text: $searchText)
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(uiColor: .systemBackground).opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.secondary.opacity(0.25), lineWidth: 1)
        }
        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
    }
}

// MARK: - Dropdown of matching results

struct SearchResultsList: View {

    let results: [Resource]

    /// How many rows to show before collapsing into a "+ N more" line.
    /// Short landscape screens pass a smaller number.
    var maxVisible: Int = 5

    /// Called when the user taps one of the results.
    let onSelect: (Resource) -> Void

    private var shown: [Resource] {
        Array(results.prefix(maxVisible))
    }

    var body: some View {
        VStack(spacing: 0) {

            if results.isEmpty {
                HStack {
                    Image(systemName: "questionmark.circle")
                    Text("No matches")
                    Spacer()
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(14)

            } else {
                ForEach(shown) { resource in

                    Button {
                        onSelect(resource)
                    } label: {
                        HStack(spacing: 10) {

                            Image(systemName: resource.category.iconName)
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .frame(width: 26, height: 26)
                                .background(resource.category.tint, in: Circle())

                            VStack(alignment: .leading, spacing: 2) {
                                Text(resource.name)
                                    .font(.subheadline.weight(.medium))
                                    .lineLimit(1)

                                Text(resource.address)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    if resource.id != shown.last?.id {
                        Divider().padding(.leading, 48)
                    }
                }

                if results.count > maxVisible {
                    Divider()
                    Text("+ \(results.count - maxVisible) more")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.15), radius: 8, y: 3)
        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
    }
}
