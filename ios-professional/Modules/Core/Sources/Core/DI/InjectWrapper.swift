//
//  InjectWrapper.swift
//
//
//  Created by Артем on 06.07.2024.
//

@propertyWrapper
public struct Injected<Service:AnyObject> {

    private var service: Service?
    private weak var serviceLocator = ServiceLocator.shared

//    public init(service: Service? = nil, serviceLocator: ServiceLocator? = nil) {
//        self.service = service
//        self.serviceLocator = serviceLocator
//    }

    public init() { }

    public var wrappedValue: Service? {
        mutating get {
            if service == nil {
                service = serviceLocator?.getService(type: Service.self)
            }
            return service
        }
        mutating set {
            service = newValue
        }
    }

    public var projectedValue: Injected<Service> {
        mutating set {self = newValue}
        get {return self}
    }
}
