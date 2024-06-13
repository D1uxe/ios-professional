//
//  TabItemType.swift
//  ios-professional
//
//  Created by Артем on 13.06.2024.
//

import SwiftUI

enum TabItemType: String {

    case tab1
    case tab2
    case tab3

    var image: Image {

        switch self {
        case .tab1: return Image(systemName: "person")
        case .tab2: return Image(systemName: "star")
        case .tab3: return Image(systemName: "gear")
        }
    }

    var text: Text {
        Text(self.rawValue)
    }

}


struct TabItemView: View {

    let tabType: TabItemType

    var body: some View {
        tabType.image
        tabType.text
    }

}
