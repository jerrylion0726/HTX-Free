//
//  AdaptiveLayout.swift
//  PublicResourceFinder
//
//  One place that decides how big things should be on each device.
//
//  iOS describes screen space with "size classes" rather than raw pixel
//  counts, which is why this file never checks for a specific device:
//
//    horizontalSizeClass == .regular  → iPad, or a large iPhone in landscape
//    verticalSizeClass   == .compact  → any iPhone in landscape (short screen)
//
//  Every view reads its numbers from here, so a layout change happens in
//  one file instead of six.
//

import SwiftUI

struct AdaptiveMetrics {

    let horizontalSizeClass: UserInterfaceSizeClass?
    let verticalSizeClass: UserInterfaceSizeClass?

    /// Lots of horizontal room: iPad, or a large iPhone turned sideways.
    /// Content is capped here so it does not stretch into unreadable lines.
    var isWide: Bool {
        horizontalSizeClass == .regular
    }

    /// Very little vertical room: an iPhone in landscape.
    /// Tall elements shrink or switch to a side-by-side layout.
    var isShort: Bool {
        verticalSizeClass == .compact
    }

    // MARK: - Map card

    var cardMaxWidth: CGFloat {
        isWide ? 460 : .infinity
    }

    var cardImageHeight: CGFloat {
        isShort ? 132 : 150
    }

    /// Width of the image when the card switches to a side-by-side layout.
    var cardImageWidth: CGFloat {
        160
    }

    // MARK: - Detail page

    var detailImageHeight: CGFloat {
        isShort ? 170 : 220
    }

    var detailMaxWidth: CGFloat {
        isWide ? 700 : .infinity
    }

    // MARK: - Search

    /// A short screen cannot afford a long dropdown over the map.
    var searchResultLimit: Int {
        isShort ? 3 : 5
    }

    // MARK: - Spacing

    var topBarSpacing: CGFloat {
        isShort ? 6 : 8
    }
}

// MARK: - Convenience

extension View {

    /// Caps a view's width and keeps it centered in whatever space is left.
    /// Passing `.infinity` leaves the view unconstrained.
    func centered(maxWidth: CGFloat) -> some View {
        self
            .frame(maxWidth: maxWidth)
            .frame(maxWidth: .infinity)
    }
}
