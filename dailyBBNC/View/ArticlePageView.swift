//
//  PostListView.swift
//  WeiboDemo
//
//  Created by 陈炜欣 on 2021/4/23.
//

import SwiftUI
import BBSwiftUIKit

import Foundation

struct ArticlePageView: View {
    @State var category: ArticlePageCategory
    
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            BBTableView(self.modelData.articlePageList[category]!) { article in
                NavigationLink(destination: ArticleDetailView(url: article.article_url)){
                    ArticleCell(article: article)
                }
                .buttonStyle(OriginalButtonStyle())
            }
            .bb_reloadData($modelData.reloadPage)
            .bb_setupRefreshControl { control in
                control.attributedTitle = NSAttributedString(string: "加载中...")
            }
            .bb_pullDownToRefresh(isRefreshing: $modelData.isRefreshing) {
                self.modelData.refreshArticlePage(for: self.category)
            }
            .bb_pullUpToLoadMore(bottomSpace: 30) {
                self.modelData.loadMoreArticlePage(for: self.category)
            }
            .onAppear {
                self.modelData.loadArticlePageIfNeeded(for: self.category)
            }
            .overlay(
                Text(modelData.loadingErrorText)
                    .bold()
                    .frame(width: 200)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .opacity(0.8)
                    )
                    .animation(nil)
                    .scaleEffect(modelData.showLoadingError ? 1 : 0.5)
                    .animation(.spring(dampingFraction: 0.5))
                    .opacity(modelData.showLoadingError ? 1 : 0)
                    .animation(.easeInOut)
        )
        }
    }
}

struct ArticlePageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ArticlePageView(category: .all).environmentObject(ModelData())
        }
        
    }
}

