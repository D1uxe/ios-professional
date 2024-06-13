//
//  Screen1.swift
//  ios-professional
//
//  Created by Артем on 13.06.2024.
//

import SwiftUI

struct Screen1: View {

    @Binding var selectedTab: TabItemType
    @Binding var selectedItem: Screen2.Item?

    var body: some View {

        NavigationView {
            Button(action: {
                selectedTab = .tab2
                selectedItem = Screen2.Item(name: "Detail 2") // Хардкод! не понятно как сделать чтобы это было из массива, который лежит в Screen2. Типа такого selectedItem = items[2]. Только используя вьюМодель? 
            }, label: {
                Text("Go to tab 2")
            })
            .navigationBarTitle("Tab 1")
        }
    }

}
