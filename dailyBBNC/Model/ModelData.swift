//
//  ArticleData.swift
//  dailyBBNC
//
//  Created by sean on 2021/5/8.
//

import Foundation
import Combine

enum ArticlePageCategory: String {
    case all = "all"
    case tech = "tech"
    case military = "military"
    case entertainment = "entertainment"
}

enum RequestType: String {
    case refresh = "1"
    case loadMore = "2"
}

class ModelData: ObservableObject {
    @Published var isRefreshing: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var loadingError: Error?
    @Published var hasMore: Bool = true
    @Published var reloadPage: Bool = false
    
    @Published var response_extra: [ArticlePageCategory:String] = [
            .all:"",
            .military:"",
            .tech:"",
            .entertainment:""
        ]
    
    @Published var articlePageList:[ArticlePageCategory:[Article]] = [
        .all: [],
        .tech: [],
        .military:[],
        .entertainment: [],
    ]
    
    @Published var articlePageDic: [ArticlePageCategory: Set<ID>] = [
        .all: Set<ID>(),
        .tech: Set<ID>(),
        .military: Set<ID>(),
        .entertainment: Set<ID>(),
    ]

}

extension ModelData {
    var showLoadingError: Bool { loadingError != nil }
    var loadingErrorText: String { loadingError?.localizedDescription ?? "" }
    
    func refreshArticlePage(for cate: ArticlePageCategory) {
        let completion: (Result<ArticlePage, Error>) -> Void = { result in
            switch result {
            case let .success(articlePage):
                self.handleRefreshArticlePage(articlePage, for: cate)
                self.handleExtra(cate: cate, extra: articlePage.extra)
                self.handleHasMore(articlePage, for: cate)
            case let .failure(error):
                self.handleLoadingError(error)
            }
            self.isRefreshing = false
        }
        
        NetworkAPI.getNewArticlePage(category: cate.rawValue, request_type: RequestType.refresh.rawValue, extra: response_extra[cate]!, completion: completion)
    }
    
    func loadMoreArticlePage(for cate: ArticlePageCategory) {
        if isLoadingMore {return}
        isLoadingMore = true
        
        let completion: (Result<ArticlePage, Error>) -> Void = { result in
            switch result {
            case let .success(articlePage):
                self.handleLoadMoreArticle(articlePage, for: cate)
                self.handleExtra(cate: cate, extra: articlePage.extra)
                self.handleHasMore(articlePage, for: cate)
            case let .failure(error): self.handleLoadingError(error)
            }
            self.isLoadingMore = false
        }
        
        NetworkAPI.getNewArticlePage(category: cate.rawValue, request_type: RequestType.loadMore.rawValue, extra: response_extra[cate]!, completion: completion)
    }
    
    private func handleRefreshArticlePage(_ page: ArticlePage, for category: ArticlePageCategory) {
        var tempPage: [Article] = []
        var tempDic = Set<ID>()
        
        for article in page.data {
            if tempDic.contains(article.gid) { continue }
            tempDic.insert(article.gid)
            tempPage.append(article)
        }
        self.articlePageList[category] = tempPage
        self.articlePageDic[category] = tempDic
    }
    
    private func handleLoadMoreArticle(_ page: ArticlePage, for category: ArticlePageCategory) {
        for article in page.data {
            if self.articlePageDic[category]!.contains(article.gid) {continue}
            self.articlePageDic[category]!.insert(article.gid)
            self.articlePageList[category]!.append(article)
        }
    }
    
    private func handleExtra(cate: ArticlePageCategory, extra: String?) {
        self.response_extra[cate] = extra ?? ""
    }
    
    private func handleHasMore(_ page: ArticlePage, for category: ArticlePageCategory) {
        self.hasMore = page.has_more ?? true
        if (self.articlePageList[category]!.count > 80) { self.hasMore = false}
    }
    
    //处理下拉刷新失败的请求
    private func handleLoadingError(_ error: Error) {
        loadingError = error
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loadingError = nil
        }
    }
    
    //开屏获取数据
    func loadArticlePageIfNeeded(for category: ArticlePageCategory) {
        if self.articlePageList[category]!.isEmpty {
            self.refreshArticlePage(for: category)
        }
    }
    
    
}
