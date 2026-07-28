//
//  ResourceImageView.swift
//  PublicResourceFinder
//
//  Shows a real image of a resource's location.
//
//  It tries three things, in order:
//    1. Apple Look Around  — an actual street-level photo of the address
//    2. Satellite imagery  — an aerial photo of the same spot
//    3. A category gradient — shown while loading, or if both fail
//
//  Nothing is downloaded or bundled, so there are no copyright concerns.
//

import SwiftUI
import MapKit

struct ResourceImageView: View {

    let resource: Resource

    /// What we managed to load for this location.
    private enum ImageState {
        case loading
        case lookAround(MKLookAroundScene)
        case satellite
    }

    @State private var state: ImageState = .loading

    var body: some View {
        ZStack {
            switch state {

            case .loading:
                gradientPlaceholder

            case .lookAround(let scene):
                LookAroundPreview(
                    initialScene: scene,
                    allowsNavigation: false,
                    showsRoadLabels: true,
                    badgePosition: .bottomTrailing
                )

            case .satellite:
                satelliteView
            }
        }
        .clipped()
        // Tying the task to the resource id means SwiftUI cancels the old
        // request and starts a fresh one whenever a different pin is tapped.
        // Without this, the view is reused and keeps the previous image.
        .task(id: resource.id) {
            state = .loading
            await loadLookAround(for: resource)
        }
    }

    // MARK: - Fallback 1: satellite imagery

    private var satelliteView: some View {
        Map(
            position: .constant(
                .region(
                    MKCoordinateRegion(
                        center: resource.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.0018, longitudeDelta: 0.0018)
                    )
                )
            ),
            interactionModes: []
        ) {
            Annotation("", coordinate: resource.coordinate, anchor: .center) {
                Circle()
                    .fill(resource.category.tint)
                    .frame(width: 14, height: 14)
                    .overlay(Circle().strokeBorder(.white, lineWidth: 2))
            }
        }
        .mapStyle(.imagery)
    }

    // MARK: - Fallback 2: category gradient

    private var gradientPlaceholder: some View {
        ZStack {
            resource.category.gradient

            Image(systemName: resource.category.iconName)
                .font(.system(size: 46, weight: .light))
                .foregroundStyle(.white.opacity(0.9))
        }
    }

    // MARK: - Loading

    /// Asks Apple whether street-level imagery exists at this coordinate.
    /// If it doesn't, we quietly fall back to the satellite view.
    private func loadLookAround(for resource: Resource) async {

        let request = MKLookAroundSceneRequest(coordinate: resource.coordinate)
        let scene = try? await request.scene

        // If the user tapped a different pin while this request was in
        // flight, this task has already been cancelled. Dropping the result
        // here stops a stale image from overwriting the current one.
        guard !Task.isCancelled else { return }

        if let scene {
            state = .lookAround(scene)
        } else {
            state = .satellite
        }
    }
}

#Preview {
    ResourceImageView(resource: allResources[0])
        .frame(height: 220)
}
