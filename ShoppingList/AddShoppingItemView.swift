//
//  AddShoppingItemView.swift
//  ShoppingList
//
//  Created by Max Kiriukhin on 02.10.2026.
//

import SwiftUI

struct AddShoppingItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var category = "Овощи и фрукты"
    @State private var quantity = 1

    let onSave: (ShoppingItem) -> Void

    private let categories: [(name: String, symbol: String, color: Color)] = [
        ("Овощи и фрукты", "carrot", .orange),
        ("Мясо и рыба", "fish", .red),
        ("Молочные продукты и яйца", "cup.and.saucer", .blue),
        ("Бакалея", "basket", .brown),
        ("Хлеб и выпечка", "birthday.cake", .orange),
        ("Напитки и сладости", "takeoutbag.and.cup.and.straw", .purple),
        ("Дом и быт", "house", .gray)
    ]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Название", text: $name)
                Picker("Категория", selection: $category) {
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
                Stepper("Количество: \(quantity)", value: $quantity, in: 1...99)
            }
            .navigationTitle("Новая покупка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                

                    ToolbarItem(placement: .confirmationAction) {
                         var symbol: String {
                            switch category {
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
                        let finalName = name.split(whereSeparator: \.isWhitespace).joined(separator: " ")
                    
                        Button("Сохранить") {
                            let item = ShoppingItem(
                                name: finalName,
                                category: category,
                                symbol: symbol,
                                quantity: quantity
                            )
                        onSave(item)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
