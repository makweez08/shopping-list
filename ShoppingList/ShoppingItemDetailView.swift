//
//  ShoppingItemDetailView.swift
//  ShoppingList
//
//  Created by Max Kiriukhin on 02.10.2026.
//


import SwiftUI

struct ShoppingItemDetailView: View {
    @Binding var item: ShoppingItem
    
    private let categories: [(name: String, symbol: String, color: Color)] = [
        ("Овощи и фрукты", "carrot", .orange),
        ("Мясо и рыба", "fish", .red),
        ("Молочные продукты и яйца", "cup.and.saucer", .blue),
        ("Бакалея", "basket", .brown),
        ("Хлеб и выпечка", "birthday.cake", .orange),
        ("Напитки и сладости", "takeoutbag.and.cup.and.straw", .purple),
        ("Дом и быт", "house", .gray)
    ]
    
    private var symbol: String {
        switch item.category {
        case "Овощи и фрукты": "carrot"
        case "Мясо и рыба": "fish"
        case "Молочные продукты и яйца": "cup.and.saucer"
        case "Бакалея": "basket"
        case "Хлеб и выпечка": "birthday.cake"
        case "Напитки и сладости": "takeoutbag.and.cup.and.straw"
        case "Дом и быт": "house"
        default: "default"
        }
    }

    var body: some View {
        Form {
            TextField("Название", text: $item.name)
            Picker("Категория", selection: $item.category) {
                ForEach(categories.indices, id: \.self) { index in
                    let item = categories[index]
                    Label {
                        Text(item.name)
                    } icon: {
                        Image(systemName: item.symbol)
                            .foregroundStyle(item.color)
                    }
                    .tag(item.name)
                }
            }
            Stepper("Количество: \(item.quantity)", value: $item.quantity, in: 1...99)
            Toggle("Куплено", isOn: $item.isPurchased)
        }
        .onChange(of: item.category) { _, _ in
            item.symbol = symbol
        }
        .onChange(of: item.name) { _, _ in
            item.name = item.name.split(whereSeparator: \.isWhitespace).joined(separator: " ")
        }
        .navigationTitle("Покупка")
        .navigationBarTitleDisplayMode(.inline)
    }
}
