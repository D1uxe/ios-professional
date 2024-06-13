//
//  Screen2.swift
//  ios-professional
//
//  Created by Артем on 13.06.2024.
//

import SwiftUI

/*
class Screen2ViewModel: ObservableObject {

    struct Item: Hashable {
        let name: String
    }

    @Published var selection: Item?

    let items = [
        Item(name: "Detail 1"),
        Item(name: "Detail 2"),
        Item(name: "Detail 3"),
        Item(name: "Detail 4")
    ]

}
*/

struct Screen2: View {

    struct Item: Hashable {
        let name: String
    }

    private let items = [
        Item(name: "Detail 1"),
        Item(name: "Detail 2"),
        Item(name: "Detail 3"),
        Item(name: "Detail 4")
    ]

    // @ObservedObject var viewModel: NavigationViewModel

    @Binding var selectedItem: Item?

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(item.name, tag: item, selection: $selectedItem) {
                        Text(item.name)
                            .navigationTitle(item.name)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }.navigationTitle("Tab2")
        }
    }

}
