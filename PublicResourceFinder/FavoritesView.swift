//
//  FavoritesView.swift
//  PublicResourceFinder
//
//  The third tab: everything the user has saved, grouped by category.
//

import SwiftUI

struct FavoritesView: View {

    @Environment(FavoritesStore.self) private var favorites

    var body: some View {
        NavigationStack {
            Group {
                if favorites.count == 0 {
                    emptyState
                } else {
                    savedList
                }
            }
            .navigationTitle("Saved")
        }
    }

    // MARK: - Empty state

    private var emptyState: some View {
        ContentUnavailableView {
            Label("No saved resources", systemImage: "heart")
        } description: {
            Text("Tap the heart on any resource to save it here for quick access.")
        }
    }

    // MARK: - The list

    private var savedList: some View {
        List {
            ForEach(favorites.favoritesByCategory, id: \.category) { group in

                Section {
                    ForEach(group.resources) { resource in
                        NavigationLink {
                            ResourceDetailView(resource: resource)
                        } label: {
                            ResourceRow(resource: resource)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    favorites.remove(resource)
                                }
                            } label: {
                                Label("Remove", systemImage: "heart.slash.fill")
                            }
                        }
                    }
                } header: {
                    Label(group.category.rawValue, systemImage: group.category.iconName)
                        .foregroundStyle(group.category.tint)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button(role: .destructive) {
                        withAnimation {
                            favorites.removeAll()
                        }
                    } label: {
                        Label("Remove All", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environment(FavoritesStore())
}
