//
//  NetworkService.swift
//
//
//  Created by Артем on 24.07.2024.
//

public class NetworkService {

    public init() { }
    
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public func fetchArticles(
        country: String,
        category: NewsCategory,
        page: Int,
        apiKey: String
    ) async throws -> HeadlineResponse {
        try await ArticlesAPI.fetchArticles(
            country: country,
            category: category,
            page: page,
            apiKey: apiKey
        )
    }
}
