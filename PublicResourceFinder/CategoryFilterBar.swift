//
//  CategoryFilterBar.swift
//  PublicResourceFinder
//
//  A horizontal row of capsule buttons for filtering by category.
//  Used by both the map screen and the list screen.
//

import SwiftUI

struct CategoryFilterBar: View {

    /// nil means "All categories".
    @Binding var selectedCategory: ResourceCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {

                FilterChip(
                    title: "All",
                    icon: "square.grid.2x2.fill",
                    tint: .gray,
                    isSelected: selectedCategory == nil
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedCategory = nil
                    }
                }

                ForEach(ResourceCategory.allCases) { category in
                    FilterChip(
                        title: category.shortName,
                        icon: category.iconName,
                        tint: category.tint,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            // Tapping the active chip turns the filter off again.
                            selectedCategory = (selectedCategory == category) ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .background(.regularMaterial)
    }
}

// MARK: - One capsule button

struct FilterChip: View {

    let title: String
    let icon: String
    let tint: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.caption)

                Text(title)
                    .font(.subheadline.weight(.medium))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? tint : Color(uiColor: .systemBackground).opacity(0.9))
            .foregroundStyle(isSelected ? .white : tint)
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .strokeBorder(tint.opacity(isSelected ? 0 : 0.35), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CategoryFilterBar(selectedCategory: .constant(nil))
}
