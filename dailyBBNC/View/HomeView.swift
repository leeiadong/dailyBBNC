//
//  HomeView.swift
//  ArticleDemo
//
//  Created by whh on 2021/4/27.
//

import SwiftUI

private let width = UIScreen.main.bounds.width
private let height = UIScreen.main.bounds.height

struct HomeView: View {
    @State var leftPercent: CGFloat = 0
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: width, contentSize: CGSize(width: width * 4, height: geometry.size.height), leftPercent: self.$leftPercent) {
                    HStack(spacing: 0) {
                        ArticlePageView(category: .all)
                            .frame(width: width )
                        ArticlePageView(category: .tech)
                            .frame(width: width )
                        ArticlePageView(category: .military)
                            .frame(width: width)
                        ArticlePageView(category: .entertainment)
                            .frame(width: width)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ModelData())
    }
}
