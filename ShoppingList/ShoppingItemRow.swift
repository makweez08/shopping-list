//
//  ShoppingItemRow.swift
//  ShoppingList
//
//  Created by Max Kiriukhin on 01.10.2026.
//

import SwiftUI

struct ShoppingItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void

    private var categoryColor: Color {
        switch item.category {
        case "Овощи и фрукты": .orange
        case "Мясо и рыба": .red
        case "Молочные продукты и яйца": .blue
        case "Бакалея": .brown
        case "Хлеб и выпечка": .orange
        case "Напитки и сладости": .purple
        case "Дом и быт": .gray
        default: .secondary
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isPurchased
                      ? "checkmark.circle.fill"
                      : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isPurchased ? .green : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .strikethrough(item.isPurchased)

                HStack(spacing: 4) {
                    Image(systemName: item.symbol)
                        .foregroundStyle(categoryColor)
                    Text("\(item.category) · \(item.quantity) шт.")
                        .foregroundStyle(.secondary)
                }
                .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview("Активная покупка") {
    ShoppingItemRow(item: ShoppingItem.samples[0]) { }
        .padding()
}

#Preview("Соверешенная покупка") {
    ShoppingItemRow(item: ShoppingItem.samples[2]) { }
        .padding()
}
