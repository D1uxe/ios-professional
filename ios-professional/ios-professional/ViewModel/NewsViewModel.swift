//
//  NewsViewModel.swift
//  ios-professional
//
//  Created by Артем on 24.06.2024.
//

import Combine
import NetworkAPI


enum PaginationState {
    case idle
    case isLoading
    case error(String)

    enum Case {
        case idle, isLoading, error, botSuggestion
    }

    var currentCase: Case {
        switch self {
        case .idle:
            return .idle
        case .isLoading:
            return .isLoading
        case .error:
            return .error
        }
    }
}

class NewsViewModel: ObservableObject {

    @Published var articles: [Article] = []
    @Published var paginationState: PaginationState = .idle
    @Published var hasMoreData = true

    private var isLoading = false
    private var page = 1
    private var totalCount = 0

    let category: NewsCategory

    init(category: NewsCategory) {
        self.category = category
    }

    func loadArticles() {

        guard !isLoading, hasMoreData else { return }
        isLoading = true
        paginationState = .isLoading

        Task { @MainActor in
            defer {
                isLoading = false
            }
            do {
                let response = try await ArticlesAPI.fetchArticles(
                    country: "ru",
                    category: category,
                    page: page,
                    apiKey: "8e7caac0fb8c4c2ba9f3324db7ed392d"
                )
                if let fetchedArticles = response.articles, !fetchedArticles.isEmpty {
                    articles.append(contentsOf: fetchedArticles)
                    totalCount = response.totalResults
                    page += 1
                    paginationState = .idle
                } else {
                    hasMoreData = false
                    paginationState = .idle
                }
            } catch {
                paginationState = .error(error.localizedDescription)
            }
        }
    }

    func loadMoreArticlesIfNeeded(currentItem item: Article) {
        let thresholdIndex = articles.index(articles.endIndex, offsetBy: -1)
        if articles.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadArticles()
        }
    }
    
}
