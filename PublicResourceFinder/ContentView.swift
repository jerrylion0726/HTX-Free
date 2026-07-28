//
//  ContentView.swift
//  PublicResourceFinder
//
//  The root screen: a tab bar holding the map, the list, and saved items.
//  It owns the category filter and the favorites store, so every tab
//  reads from the same source of truth.
//

import SwiftUI

struct ContentView: View {

    /// nil means "All categories". Shared by the map and list tabs.
    @State private var selectedCategory: ResourceCategory?

    /// One store for the whole app, handed down through the environment.
    @State private var favorites = FavoritesStore()

    var body: some View {
        TabView {

            MapView(selectedCategory: $selectedCategory)
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }

            ResourceListView(selectedCategory: $selectedCategory)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }

            FavoritesView()
                .tabItem {
                    Label("Saved", systemImage: "heart.fill")
                }
                .badge(favorites.count)
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
