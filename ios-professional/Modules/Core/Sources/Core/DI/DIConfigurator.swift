//
//  DIConfigurator.swift
//
//
//  Created by Артем on 04.07.2024.
//

class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()

    func setup() {
        registerServices()
    }

   private func registerServices() {
//        serviceLocator.addService(service: MockNetworkService())
//        serviceLocator.addService(service: MockDatabaseService())
    }
}
