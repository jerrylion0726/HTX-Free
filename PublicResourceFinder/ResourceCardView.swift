//
//  ResourceCardView.swift
//  PublicResourceFinder
//
//  The card that slides up from the bottom when a map pin is tapped.
//

import SwiftUI

struct ResourceCardView: View {

    let resource: Resource

    /// Called when the user taps the close button.
    let onClose: () -> Void

    /// Called when the user taps "Learn More".
    let onLearnMore: () -> Void

    @Environment(FavoritesStore.self) private var favorites

    private var isSaved: Bool {
        favorites.isFavorite(resource)
    }

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Image

            ResourceImageView(resource: resource)
                .frame(height: 150)
                .overlay(alignment: .topTrailing) {
                    closeButton
                }
                .overlay(alignment: .topLeading) {
                    favoriteButton
                }

            // MARK: Text

            VStack(alignment: .leading, spacing: 8) {

                Label(resource.category.rawValue, systemImage: resource.category.iconName)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(resource.category.tint)

                Text(resource.name)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Text(resource.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(resource.hours)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                // MARK: Directions + Learn More

                HStack(spacing: 10) {

                    // Quick directions without opening the detail page first.
                    DirectionsMenu(resource: resource) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                            Text("Go")
                                .font(.subheadline.weight(.semibold))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 18)
                        .background(resource.category.tint.opacity(0.15))
                        .foregroundStyle(resource.category.tint)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button(action: onLearnMore) {
                        HStack {
                            Text("Learn More")
                                .font(.subheadline.weight(.semibold))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.bold))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background(resource.category.tint)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.25), radius: 12, y: 4)
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
