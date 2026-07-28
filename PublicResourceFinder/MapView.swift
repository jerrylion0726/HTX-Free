//
//  MapView.swift
//  PublicResourceFinder
//
//  The map screen: search + category filter on top,
//  colored pins on the map, and a detail card sliding up from the bottom.
//

import SwiftUI
import MapKit

struct MapView: View {

    /// Shared with the list tab. nil means "All categories".
    @Binding var selectedCategory: ResourceCategory?

    /// The starting camera: Houston, zoomed out far enough to see everything.
    private static let houstonRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.7800, longitude: -95.4200),
        span: MKCoordinateSpan(latitudeDelta: 0.45, longitudeDelta: 0.45)
    )

    @State private var cameraPosition: MapCameraPosition = .region(houstonRegion)

    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool

    /// The pin the user tapped, if any. Drives the bottom card.
    @State private var selectedResource: Resource?

    /// Set when the user taps "Learn More". Drives the detail page.
    @State private var detailResource: Resource?

    // MARK: - Filtering

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

    private var isSearching: Bool {
        !searchText.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {

                ForEach(visibleResources) { resource in
                    Annotation(
                        resource.name,
                        coordinate: resource.coordinate,
                        anchor: .center
                    ) {
                        MapPinView(
                            category: resource.category,
                            isSelected: selectedResource?.id == resource.id
                        )
                        .onTapGesture {
                            isSearchFocused = false
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selectedResource = resource
                            }
                        }
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .navigationTitle(selectedCategory?.rawValue ?? "Houston Resources")
            .navigationBarTitleDisplayMode(.inline)

            // MARK: Search + filter across the top
            .safeAreaInset(edge: .top) {
                VStack(spacing: 8) {

                    MapSearchBar(searchText: $searchText, isFocused: $isSearchFocused)
                        .padding(.horizontal, 12)

                    if isSearching {
                        SearchResultsList(results: visibleResources) { resource in
                            fly(to: resource)
                        }
                        .padding(.horizontal, 12)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    CategoryFilterBar(selectedCategory: $selectedCategory)
                }
                .padding(.top, 8)
                .background(.regularMaterial)
                .animation(.easeInOut(duration: 0.2), value: isSearching)
            }

            // MARK: The card that slides up from the bottom
            .safeAreaInset(edge: .bottom) {
                if let selectedResource {
                    ResourceCardView(
                        resource: selectedResource,
                        onClose: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.selectedResource = nil
                            }
                        },
                        onLearnMore: {
                            detailResource = selectedResource
                        }
                    )
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }

            // Changing the filter can hide the pin that is currently selected.
            .onChange(of: selectedCategory) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedResource = nil
                }
            }

            // Clearing the search returns the camera to the whole city.
            .onChange(of: searchText) {
                if searchText.isEmpty {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        cameraPosition = .region(Self.houstonRegion)
                    }
                }
            }

            .navigationDestination(item: $detailResource) { resource in
                ResourceDetailView(resource: resource)
            }
        }
    }

    // MARK: - Camera

    /// Animates the camera to a resource and opens its card.
    private func fly(to resource: Resource) {

        isSearchFocused = false

        // The animation duration is what makes the camera glide
        // instead of jumping straight to the new coordinate.
        withAnimation(.easeInOut(duration: 1.0)) {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: resource.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                )
            )
        }

        // Let the camera travel for a moment before the card appears,
        // so the two animations do not fight for the screen.
        Task {
            try? await Task.sleep(for: .milliseconds(700))
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                selectedResource = resource
            }
        }
    }
}

// MARK: - The pin itself

/// A circular pin tinted by category, with the category icon inside.
/// Grows slightly when it is the selected pin.
struct MapPinView: View {

    let category: ResourceCategory
    var isSelected: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .fill(category.tint)
                .shadow(color: .black.opacity(0.3), radius: 3, y: 2)

            Circle()
                .strokeBorder(.white, lineWidth: isSelected ? 3 : 2)

            Image(systemName: category.iconName)
                .font(.system(size: isSelected ? 17 : 14, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(width: isSelected ? 40 : 32, height: isSelected ? 40 : 32)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

#Preview {
    MapView(selectedCategory: .constant(nil))
}
