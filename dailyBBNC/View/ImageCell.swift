//
//  ImageCell.swift
//  dailyBBNC
//
//  Created by sean on 2021/5/8.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageCell: View {
    let images: [Cover]
    let width: CGFloat
    
    var body: some View {
        HStack {
            ForEach(images.indices, id: \.self) { index in
                getImage(name: images[index].url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width / CGFloat(images.count), height: (width / CGFloat(images.count)) * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Rectangle())
            }
        }
    }
}

func getImage(name: String) -> WebImage {
    WebImage(url: URL(string: name)!)
        .placeholder { Color.gray }
}
