import Foundation
import SwiftUI

struct ShoppingItem: Identifiable, Hashable {
    let id: UUID
    var name: String
    var category: String
    var symbol: String
    var quantity: Int
    var isPurchased: Bool

    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        symbol: String = "",
        quantity: Int = 1,
        isPurchased: Bool = false,
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.symbol = symbol
        self.quantity = quantity
        self.isPurchased = isPurchased
    }
}

extension ShoppingItem {
    static let samples = [
        ShoppingItem(name: "Молоко", category: "Молочные продукты и яйца", symbol: "cup.and.saucer", quantity: 2),
        ShoppingItem(name: "Блокнот", category: "Дом и быт", symbol: "house"),
        ShoppingItem(name: "Батарейки", category: "Дом и быт", symbol: "house", isPurchased: true)
    ]
}
