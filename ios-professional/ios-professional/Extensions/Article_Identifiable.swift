//
//  Article_Identifiable.swift
//  ios-professional
//
//  Created by Бугров Артем on 23.06.2024.
//

import NetworkAPI

extension Article: Identifiable {
    public var id: String { url }
}
