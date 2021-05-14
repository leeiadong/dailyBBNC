//
//  NetworkManager.swift
//  dailyTop
//
//  Created by sean on 2021/4/25.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data,Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

let NetworkAPIBaseURL = "https://i.snssdk.com/mooc/stream/api/"

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //封装get请求
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseURL + path,
                   parameters: parameters,
                   requestModifier: {$0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(.failure(error))
                }
            }
    }
}
