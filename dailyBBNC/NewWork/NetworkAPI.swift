//
//  NetworkAPI.swift
//  dailyBBNC
//
//  Created by sean on 2021/5/5.
//

import Foundation

class NetworkAPI {
    static func getNewArticlePage(category: String, request_type: String, extra: String, completion: @escaping (Result<ArticlePage, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "list/", parameters:["category":"\(category)","request_type":"\(request_type)", "response_extra":"\(extra)"]) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<ArticlePage, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        let decodedData = try! JSONDecoder().decode(T.self, from: data)
        return .success(decodedData)
    }
}
