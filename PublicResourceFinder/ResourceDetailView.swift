//
//  ResourceDetailView.swift
//  PublicResourceFinder
//
//  The full page for a single resource, reached from "Learn More"
//  or from tapping a row in the list.
//

import SwiftUI
import MapKit

struct ResourceDetailView: View {

    let resource: Resource

    @Environment(\.openURL) private var openURL
    @Environment(FavoritesStore.self) private var favorites

    private var isSaved: Bool {
        favorites.isFavorite(resource)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: Header image

                ResourceImageView(resource: resource)
                    .frame(height: 220)

                VStack(alignment: .leading, spacing: 20) {

                    // MARK: Title

                    VStack(alignment: .leading, spacing: 6) {

                        Label(resource.category.rawValue, systemImage: resource.category.iconName)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(resource.category.tint)

                        Text(resource.name)
                            .font(.title2.bold())
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    // MARK: Action buttons

                    HStack(spacing: 12) {

                        // Tapping this opens a Drive / Walk / Transit menu.
                        DirectionsMenu(resource: resource) {
                            actionLabel(
                                title: "Directions",
                                icon: "arrow.triangle.turn.up.right.circle.fill"
                            )
                        }

                        Button {
                            if let url = URL(string: "tel://\(resource.dialablePhone)") {
                                openURL(url)
                            }
                        } label: {
                            actionLabel(title: "Call", icon: "phone.fill")
                        }

                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                favorites.toggle(resource)
                            }
                        } label: {
                            actionLabel(
                                title: isSaved ? "Saved" : "Save",
                                icon: isSaved ? "heart.fill" : "heart"
                            )
                        }
                    }

                    Divider()

                    // MARK: Info rows

                    infoRow(icon: "mappin.and.ellipse", title: "Address", value: resource.address)
                    infoRow(icon: "clock.fill", title: "Hours", value: resource.hours)
                    infoRow(icon: "phone.fill", title: "Phone", value: resource.phone)

                    if resource.hasWebsite {
                        Button {
                            if let url = URL(string: resource.website) {
                                openURL(url)
                            }
                        } label: {
                            infoRow(icon: "globe", title: "Website", value: resource.website)
                        }
                        .buttonStyle(.plain)
                    }

                    Divider()

                    // MARK: About

                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.headline)

                        Text(resource.details)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    // MARK: Disclaimer

                    Text("Hours and services can change. Call ahead before visiting. Data collected July 2026.")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea(edges: .top)
        .navigationTitle(resource.category.shortName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        favorites.toggle(resource)
                    }
                } label: {
                    Image(systemName: isSaved ? "heart.fill" : "heart")
                        .foregroundStyle(isSaved ? .red : .primary)
                }
            }
        }
    }

    // MARK: - Small building blocks

    /// The shared look of the three action buttons.
    private func actionLabel(title: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
            Text(title)
                .font(.caption.weight(.medium))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(resource.category.tint.opacity(0.12))
        .foregroundStyle(resource.category.tint)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func infoRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {

            Image(systemName: icon)
                .font(.subheadline)
                .foregroundStyle(resource.category.tint)
                .frame(width: 22)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
    }
}

#Preview {
    NavigationStack {
        ResourceDetailView(resource: allResources[0])
    }
    .environment(FavoritesStore())
}
