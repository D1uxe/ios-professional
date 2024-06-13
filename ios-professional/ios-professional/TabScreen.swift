//
//  ContentView.swift
//  ios-professional
//
//  Created by Бугров Артем on 03.06.2024.
//

import SwiftUI

struct TabScreen: View {

    @State private var selectedTab = TabItemType.tab1
    @State private var selectedItem: Screen2.Item?

    var body: some View {

        TabView(selection: $selectedTab) {
            Screen1(selectedTab: $selectedTab, selectedItem: $selectedItem)
                .tabItem {
                    TabItemView(tabType: .tab1)
                }.tag(TabItemType.tab1)

            Screen2(selectedItem: $selectedItem)
                .tabItem {
                    TabItemView(tabType: .tab2)
                }.tag(TabItemType.tab2)

            Screen3()
                .tabItem {
                    TabItemView(tabType: .tab3)
                }.tag(TabItemType.tab3)
        }
    }
}

#Preview {
    TabScreen()
}
