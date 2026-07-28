//
//  DirectionsHelper.swift
//  PublicResourceFinder
//
//  Opens a resource in the Apple Maps app with directions.
//
//  Note: iOS does not let third-party apps run turn-by-turn voice
//  navigation themselves. Handing off to the Maps app is the standard
//  approach every app uses for this.
//

import Foundation
import MapKit
import SwiftUI

// MARK: - Travel mode

enum TravelMode: String, CaseIterable, Identifiable {
    case driving = "Drive"
    case walking = "Walk"
    case transit = "Transit"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .driving: return "car.fill"
        case .walking: return "figure.walk"
        case .transit: return "bus.fill"
        }
    }

    /// The key Apple Maps expects for this mode.
    var launchOption: String {
        switch self {
        case .driving: return MKLaunchOptionsDirectionsModeDriving
        case .walking: return MKLaunchOptionsDirectionsModeWalking
        case .transit: return MKLaunchOptionsDirectionsModeTransit
        }
    }
}

// MARK: - Opening Maps

enum DirectionsHelper {

    /// Launches the Maps app with directions to this resource.
    static func open(_ resource: Resource, mode: TravelMode) {

        let placemark = MKPlacemark(coordinate: resource.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = resource.name

        mapItem.openInMaps(
            launchOptions: [MKLaunchOptionsDirectionsModeKey: mode.launchOption]
        )
    }
}

// MARK: - Reusable menu

/// A button that shows Drive / Walk / Transit and hands off to Maps.
/// Wrap it around any label you like.
struct DirectionsMenu<Label: View>: View {

    let resource: Resource
    @ViewBuilder let label: () -> Label

    var body: some View {
        Menu {
            ForEach(TravelMode.allCases) { mode in
                Button {
                    DirectionsHelper.open(resource, mode: mode)
                } label: {
                    SwiftUI.Label(mode.rawValue, systemImage: mode.iconName)
                }
            }
        } label: {
            label()
        }
    }
}
