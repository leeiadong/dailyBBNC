//
//  ArticleList.swift
//  dailyTop
//
//  Created by sean on 2021/4/24.
//
import Foundation
import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct ArticlePage: Codable {
    let code: Int
    let message: String
    var has_more: Bool?
    let tips: String?
    var data: [Article]
    let extra: String
}

struct Article: Codable {
    let gid: String
    let cell_type: Int
    let title: String
    let article_url: String
    let covers: [Cover]?
    
    let publish_time: Int?
    let author_info: Author?
    
    
    var resolvedTime: Int{
        publish_time ?? 0
    }
    var resolvedAuthor: Author {
        author_info ?? Author(user_name: "null", avatar: "null")
    }
    
    var resolvedCovers: [Cover] {
        covers ?? []
    }
}

extension Article: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.gid == rhs.gid
    }
}

extension Article {
    var time: String {
        if publish_time != nil {
            return getStringFromTimeStamp(publish_time!, dateFormat: "yyyy-MM-dd")
        } else {
            return ""
        }
    }
}

struct Author: Codable {
    let user_name: String
    let avatar: String
}

struct Cover: Codable {
    let url: String
    let width: Int
    let height: Int
    let url_large: String
}

func getStringFromTimeStamp(_ time: Int, dateFormat:String="yyyy-MM-dd") -> String {
    let interval:TimeInterval = TimeInterval.init(time)
    let date:Date = Date(timeIntervalSince1970: interval)
    let timeZone = TimeZone.init(identifier: "UTC")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = Locale.init(identifier: "zh_CN")
    formatter.dateFormat = dateFormat
    let dateString = formatter.string(from: date)
    return dateString.components(separatedBy: " ").first!
}

typealias ID = String

let loadArticlePage = loadData("test_response.json")

//加载json,解析文件
func loadData(_ fileName: String) -> ArticlePage {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)") //从url加载数据
    }
    guard let list = try? JSONDecoder().decode(ArticlePage.self, from: data) else {
        fatalError("Can not parse post list json data")
    } //解析类型，传递需要加.self
    return list
}
