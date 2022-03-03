//
//  ArticleAPIRequest.swift
//  RxSwiftAPIExample
//
//  Created by KOVIGROUP on 26/02/2022
//

import Foundation

class ArticleAPIRequest: APIRequest {
    var method = RequestType.GET
    var path = "search"
    var parameters = [String: String]()

    init(name: String) {
        parameters["name"] = name
    }
}

protocol APIRequest {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue(applicationJosn, forHTTPHeaderField: acceptType)
        return request
    }
}
