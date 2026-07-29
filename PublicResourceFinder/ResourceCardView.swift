//
//  ResourceCardView.swift
//  PublicResourceFinder
//
//  The card that slides up from the bottom when a map pin is tapped.
//
//  It has two layouts:
//    - Stacked (image on top) when there is vertical room
//    - Side by side (image on the left) on a short landscape screen
//

import SwiftUI

struct ResourceCardView: View {

    let resource: Resource
    let onClose: () -> Void
    let onLearnMore: () -> Void

    @Environment(FavoritesStore.self) private var favorites
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass

    private var metrics: AdaptiveMetrics {
        AdaptiveMetrics(
            horizontalSizeClass: hSizeClass,
            verticalSizeClass: vSizeClass
        )
    }

    private var isSaved: Bool {
        favorites.isFavorite(resource)
    }

    var body: some View {
        Group {
            if metrics.isShort {
                sideBySideLayout
            } else {
                stackedLayout
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .topTrailing) { closeButton }
        .shadow(color: .black.opacity(0.25), radius: 12, y: 4)
        // Stops very large accessibility text sizes from breaking the card.
        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
        .centered(maxWidth: metrics.cardMaxWidth)
    }

    // MARK: - Layout 1: image on top

    private var stackedLayout: some View {
        VStack(spacing: 0) {

            ResourceImageView(resource: resource)
                .frame(height: metrics.cardImageHeight)
                .overlay(alignment: .topLeading) { favoriteButton }

            VStack(alignment: .leading, spacing: 8) {
                categoryLabel
                nameText
                addressText
                hoursText

                HStack(spacing: 10) {
                    directionsButton
                    learnMoreButton
                }
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
    }

    // MARK: - Layout 2: image on the left

    private var sideBySideLayout: some View {
        HStack(spacing: 0) {

            ResourceImageView(resource: resource)
                .frame(width: metrics.cardImageWidth)
                .overlay(alignment: .topLeading) { favoriteButton }

            VStack(alignment: .leading, spacing: 6) {
                categoryLabel
                nameText
                addressText

                HStack(spacing: 8) {
                    directionsButton
                    learnMoreButton
                }
                .padding(.top, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .padding(.trailing, 26)
        }
        .frame(height: metrics.cardImageHeight)
    }

    // MARK: - Shared pieces

    private var categoryLabel: some View {
        Label(resource.category.rawValue, systemImage: resource.category.iconName)
            .font(.caption.weight(.semibold))
            .foregroundStyle(resource.category.tint)
    }

    private var nameText: some View {
        Text(resource.name)
            .font(.headline)
            .lineLimit(metrics.isShort ? 2 : 3)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var addressText: some View {
        Text(resource.address)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .lineLimit(metrics.isShort ? 1 : 2)
    }

    private var hoursText: some View {
        Text(resource.hours)
            .font(.caption)
            .foregroundStyle(.secondary)
            .lineLimit(2)
    }

    private var directionsButton: some View {
        DirectionsMenu(resource: resource) {
            HStack(spacing: 6) {
                Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                Text("Go")
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.vertical, metrics.isShort ? 9 : 12)
            .padding(.horizontal, metrics.isShort ? 14 : 18)
            .background(resource.category.tint.opacity(0.15))
            .foregroundStyle(resource.category.tint)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var learnMoreButton: some View {
        Button(action: onLearnMore) {
            HStack {
                Text("Learn More")
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                Spacer(minLength: 4)
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
            }
            .padding(.vertical, metrics.isShort ? 9 : 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(resource.category.tint)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Overlay buttons

    private var favoriteButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                favorites.toggle(resource)
            }
        } label: {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(isSaved ? .red : .primary)
                .padding(8)
                .background(.regularMaterial, in: Circle())
        }
        .buttonStyle(.plain)
        .padding(10)
    }

    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.primary)
                .padding(8)
                .background(.regularMaterial, in: Circle())
        }
        .buttonStyle(.plain)
        .padding(10)
    }
}

#Preview {
    ResourceCardView(
        resource: allResources[0],
        onClose: {},
        onLearnMore: {}
    )
    .padding()
    .environment(FavoritesStore())
}
