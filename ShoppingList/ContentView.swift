//
//  ContentView.swift
//  ShoppingList
//
//  Created by Max Kiriukhin on 01.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var items = ShoppingItem.samples
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State private var sortType = "All"

    private var visibleItems: [ShoppingItem] {
        guard !searchText.isEmpty else { return items.filter {
            sortType == "All" || $0.isPurchased == (sortType == "Bought")
        } }
        return items.filter {
            ($0.name.localizedCaseInsensitiveContains(searchText)
             || $0.category.localizedCaseInsensitiveContains(searchText)) && (sortType == "All" || $0.isPurchased == (sortType == "Bought"))
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if visibleItems.isEmpty {
                    ContentUnavailableView {
                        Label("Список покупок пуст", systemImage: "basket")
                    } description: {
                        Text("Добавьте первую покупку — она появится здесь.")
                    }
                } else {
                    ForEach(visibleItems) { item in
                        NavigationLink(value: item.id) {
                            ShoppingItemRow(item: item) {
                                toggle(item)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Покупки")
            .searchable(text: $searchText, prompt: "Название или категория")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("", selection: $sortType) {
                        Text("Все").tag("All")
                        Text("Куплено").tag("Bought")
                        Text("Нужно купить").tag("ShouldBeBought")
                    }
                    .pickerStyle(.menu)
                    .fixedSize()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить", systemImage: "plus") {
                        showingAddItem = true
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddShoppingItemView { newItem in
                    items.append(newItem)
                }
            }
            .navigationDestination(for: UUID.self) { id in
                if let index = items.firstIndex(where: { $0.id == id }) {
                    ShoppingItemDetailView(item: $items[index])
                }
            }
        }
    }

    private func toggle(_ item: ShoppingItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        items[index].isPurchased.toggle()
    }

    private func delete(at offsets: IndexSet) {
        let ids = offsets.map { visibleItems[$0].id }
        items.removeAll { ids.contains($0.id) }
    }
}

#Preview {
    ContentView()
}
