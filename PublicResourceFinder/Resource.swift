//
//  Resource.swift
//  PublicResourceFinder
//
//  The data model for a single public resource.
//

import Foundation
import CoreLocation
import SwiftUI

// MARK: - Resource Category

/// The five kinds of public resources this app tracks.
enum ResourceCategory: String, CaseIterable, Codable, Identifiable {
    case library         = "Library"
    case foodAssistance  = "Food Assistance"
    case communityCenter = "Community Center"
    case healthClinic    = "Health Clinic"
    case education       = "Education"

    var id: String { rawValue }

    /// SF Symbol shown on the map pin, in the list, and on the detail header.
    var iconName: String {
        switch self {
        case .library:         return "books.vertical.fill"
        case .foodAssistance:  return "basket.fill"
        case .communityCenter: return "building.2.fill"
        case .healthClinic:    return "cross.case.fill"
        case .education:       return "graduationcap.fill"
        }
    }

    /// Short label used on the filter buttons.
    var shortName: String {
        switch self {
        case .library:         return "Library"
        case .foodAssistance:  return "Food"
        case .communityCenter: return "Community"
        case .healthClinic:    return "Health"
        case .education:       return "Education"
        }
    }

    /// Each category gets its own color so map pins are readable at a glance.
    var tint: Color {
        switch self {
        case .library:         return .blue
        case .foodAssistance:  return .orange
        case .communityCenter: return .purple
        case .healthClinic:    return .red
        case .education:       return .green
        }
    }

    /// Used as the "photo" area on cards and detail pages.
    var gradient: LinearGradient {
        LinearGradient(
            colors: [tint.opacity(0.9), tint.opacity(0.4)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Resource

/// A single public resource: a library, pantry, clinic, and so on.
struct Resource: Identifiable, Codable, Hashable {

    /// A stable, hand-written ID. It must never change, because saved
    /// favorites are stored by this value.
    let id: String

    let name: String
    let category: ResourceCategory
    let address: String
    let hours: String
    let phone: String
    let details: String

    /// Empty string means no verified website is available.
    let website: String

    let latitude: Double
    let longitude: Double

    /// The map pin location for this resource.
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    /// True when this resource has a website worth showing a link for.
    var hasWebsite: Bool {
        !website.isEmpty
    }

    /// Phone number reduced to digits, for the "Call" button.
    var dialablePhone: String {
        phone.filter { character in character.isNumber }
    }

    /// Everything the search bar should look through, lowercased once
    /// so the search itself stays fast and simple.
    var searchText: String {
        "\(name) \(category.rawValue) \(address) \(details)".lowercased()
    }
}
