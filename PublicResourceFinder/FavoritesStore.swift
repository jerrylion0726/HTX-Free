//
//  FavoritesStore.swift
//  PublicResourceFinder
//
//  Keeps track of which resources the user has saved.
//
//  Favorites are stored as a set of resource ids in UserDefaults, which is
//  iOS's built-in storage for small amounts of data. It survives app
//  restarts without needing a database or a network connection.
//

import Foundation
import Observation

@Observable
final class FavoritesStore {

    /// The key UserDefaults files this data under. Changing it would
    /// orphan everything the user has already saved, so leave it alone.
    private static let storageKey = "savedFavoriteResourceIDs"

    /// The ids of every saved resource.
    private(set) var favoriteIDs: Set<String> = []

    init() {
        load()
    }

    // MARK: - Reading

    func isFavorite(_ resource: Resource) -> Bool {
        favoriteIDs.contains(resource.id)
    }

    var count: Int {
        favoriteIDs.count
    }

    /// Saved resources, grouped by category, in the app's normal
    /// category order. Empty categories are left out.
    var favoritesByCategory: [(category: ResourceCategory, resources: [Resource])] {

        ResourceCategory.allCases.compactMap { category in

            let matches = allResources.filter { resource in
                resource.category == category && favoriteIDs.contains(resource.id)
            }

            return matches.isEmpty ? nil : (category, matches)
        }
    }

    // MARK: - Writing

    func toggle(_ resource: Resource) {
        if favoriteIDs.contains(resource.id) {
            favoriteIDs.remove(resource.id)
        } else {
            favoriteIDs.insert(resource.id)
        }
        save()
    }

    func remove(_ resource: Resource) {
        favoriteIDs.remove(resource.id)
        save()
    }

    func removeAll() {
        favoriteIDs.removeAll()
        save()
    }

    // MARK: - Persistence

    private func save() {
        // UserDefaults cannot store a Set directly, so it goes in as an array.
        UserDefaults.standard.set(Array(favoriteIDs), forKey: Self.storageKey)
    }

    private func load() {
        let saved = UserDefaults.standard.stringArray(forKey: Self.storageKey) ?? []

        // Only keep ids that still exist in the data file. This stops old
        // favorites from lingering if a resource is ever removed.
        let knownIDs = Set(allResources.map { resource in resource.id })
        favoriteIDs = Set(saved).intersection(knownIDs)
    }
}
