//
//  ContentView.swift
//  ios-professional
//
//  Created by Бугров Артем on 03.06.2024.
//

import SwiftUI
import NetworkAPI

struct ContentView: View {

    @State private var selectedCategory: NewsCategory = .business
    @State private var viewModels: [NewsCategory: NewsViewModel] = NewsCategory.allCases.reduce(into: [:]) { result, category in
        result[category] = NewsViewModel(category: category)
    }

    var body: some View {
        VStack {
            Picker("picker", selection: $selectedCategory) {
                ForEach(NewsCategory.allCases) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedCategory, initial: true) {
                if let viewModel = viewModels[selectedCategory], viewModel.articles.isEmpty {
                    viewModel.loadArticles()
                }
            }

            if let viewModel = viewModels[selectedCategory] {
                ArticleListView(viewModel: viewModel)
            }

        }
        .padding()
    }
}


struct ArticleListView: View {

    @ObservedObject var viewModel: NewsViewModel

    @State private var animate = false
    @State private var flyAway = false
    @State private var flyOffset = CGPoint.zero
    @State private var currentArticle: (title: String?, description: String?)?
    @State private var cellSize: CGSize = .zero

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.articles) { article in
                    ArticleCell(
                        title: article.title,
                        description: article.description,
                        onAnimate: { offset, size in
                            self.flyOffset = offset
                            self.currentArticle = (article.title, article.description)
                            self.cellSize = size
                            self.animate = true
                        }
                    )
                    .onAppear {
                        viewModel.loadMoreArticlesIfNeeded(currentItem: article)
                    }
                }
                if viewModel.hasMoreData {
                    lastRowView
                }
            }

            if animate, let article = currentArticle {
                ArticleFlyawayView(
                    title: article.title,
                    description: article.description,
                    size: cellSize,
                    animate: $animate,
                    flyOffset: $flyOffset,
                    flyAway: $flyAway
                )
            }
        }
    }

    var lastRowView: some View {
        ZStack(alignment: .center) {

            switch viewModel.paginationState {

            case .isLoading:
                ProgressView()

            case .idle:
                EmptyView()

            case .error(let error):
                Text(error).font(.footnote)
            }
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    ContentView()
}
