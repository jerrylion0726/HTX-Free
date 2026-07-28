//
//  ResourceListView.swift
//  PublicResourceFinder
//
//  The list screen: searchable, filtered list of every resource.
//  Swipe a row to save or unsave it.
//

import SwiftUI

struct ResourceListView: View {

    /// Shared with the map tab. nil means "All categories".
    @Binding var selectedCategory: ResourceCategory?

    @State private var searchText = ""

    @Environment(FavoritesStore.self) private var favorites

    /// Category filter first, then the search text on top of it.
    private var visibleResources: [Resource] {

        var results = allResources

        if let selectedCategory {
            results = results.filter { resource in
                resource.category == selectedCategory
            }
        }

        let query = searchText.trimmingCharacters(in: .whitespaces).lowercased()

        if !query.isEmpty {
            results = results.filter { resource in
                resource.searchText.contains(query)
            }
        }

        return results
    }

    var body: some View {
        NavigationStack {
            List {
                if visibleResources.isEmpty {
                    ContentUnavailableView(
                        "No matches",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different search or category.")
                    )

                } else {
                    Section {
                        ForEach(visibleResources) { resource in
                            NavigationLink {
                                ResourceDetailView(resource: resource)
                            } label: {
                                ResourceRow(
                                    resource: resource,
                                    isSaved: favorites.isFavorite(resource)
                                )
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    withAnimation {
                                        favorites.toggle(resource)
                                    }
                                } label: {
                                    if favorites.isFavorite(resource) {
                                        Label("Unsave", systemImage: "heart.slash.fill")
                                    } else {
                                        Label("Save", systemImage: "heart.fill")
                                    }
                                }
                                .tint(favorites.isFavorite(resource) ? .gray : .red)
                            }
                        }
                    } header: {
                        Text("\(visibleResources.count) resources")
                    }
                }
            }
            .navigationTitle(selectedCategory?.rawValue ?? "All Resources")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search name, address, or service"
            )
            .safeAreaInset(edge: .top) {
                CategoryFilterBar(selectedCategory: $selectedCategory)
            }
        }
    }
}

// MARK: - One row in the list

struct ResourceRow: View {

    let resource: Resource

    /// Shows a small heart when the resource is saved.
    var isSaved: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // Category icon, tinted to match the map pin
            Image(systemName: resource.category.iconName)
                .font(.title3)
                .foregroundStyle(resource.category.tint)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {

                Text(resource.name)
                    .font(.headline)

                Text(resource.category.rawValue)
                    .font(.caption)
                    .foregroundStyle(resource.category.tint)

                Text(resource.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            if isSaved {
                Image(systemName: "heart.fill")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ResourceListView(selectedCategory: .constant(nil))
        .environment(FavoritesStore())
}
