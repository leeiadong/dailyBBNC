//
//  ArticleCell.swift
//  dailyBBNC
//
//  Created by sean on 2021/5/7.
//

import SwiftUI
import SDWebImageSwiftUI

private let width = UIScreen.main.bounds.width - 20

struct ArticleCell: View {
    var article: Article
    var beidianjiguo: CGFloat = 1 // 1 means mei bei dian ji guo, to 0.5 if dianjiguo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Rectangle()
                .padding(.horizontal, -10)
                .frame(height: 10)
                .foregroundColor(.white)
            Text(article.title)
                .font(.title3)
                .fontWeight(.regular)
            
            if !(article.covers ?? []).isEmpty  {
                ImageCell(images: article.covers!, width: width - 20).frame(alignment: .center)
            }
            
            if (article.cell_type == 0) {
                Text(article.author_info!.user_name + "     " + String(article.time))
                    .font(.footnote)
                    .fontWeight(.thin)
            } else {
                Text("广告")
                    .font(.footnote)
                    .fontWeight(.thin)
            }
            Divider()
        }
        .frame(width: width , alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .opacity(Double(beidianjiguo))
    }
}



struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: loadArticlePage.data[2])
    }
}
