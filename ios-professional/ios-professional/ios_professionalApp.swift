//
//  ios_professionalApp.swift
//  ios-professional
//
//  Created by Бугров Артем on 03.06.2024.
//

import SwiftUI
import Core
import NetworkAPI

@main
struct ios_professionalApp: App {
    init() {
        ServiceLocator.shared.addService(service: NetworkService())
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
