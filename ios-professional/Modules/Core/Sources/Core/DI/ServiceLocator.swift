//
//  ServiceLocator.swift
//
//
//  Created by Артем on 04.07.2024.
//

import Foundation

public class ServiceLocator : NSObject {

    public static let shared = ServiceLocator()
    
    private var containerServices = [String: AnyObject]()

    public func addService<T:AnyObject>(service: T) {
        let key = "\(T.self)"
        if containerServices[key] == nil {
            containerServices[key] = service
        }
    }

    public func getService<T:AnyObject>(type: T.Type)->T? {
        let key = "\(T.self)"
        return containerServices[key] as? T
    }
}
