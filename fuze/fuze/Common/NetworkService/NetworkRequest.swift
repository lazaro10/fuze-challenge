//
//  NetworkRequest.swift
//  fuze
//
//  Created by Firenze on 18/11/22.
//

import Foundation

protocol NetworkRequest {
    var baseURL: BaseURL { get }
    var path: String { get }
    var method: NetworkServiceMethod { get }
    var queryParameters: [String: String] { get }
    var bodyParameters: [String: Any]? { get }
    var headers: [String: String] { get }
}

extension NetworkRequest {
    var baseURL: BaseURL { .pandaScore }
    var queryParameters: [String: Any] { [:] }
    var bodyParameters: [String: Any]? { nil }
    var headers: [String: String] { [:] }
}

enum NetworkRequestError: Error, Equatable {
    case invalidPath
    case invalidURL
    case invalidBodyParameters
}

extension NetworkRequest {
    func toRequest(baseURL: URL) throws -> URLRequest {
        guard var urlPathComponent = URLComponents(string: path) else {
            throw NetworkRequestError.invalidPath
        }
        
        urlPathComponent.queryItems = queryParameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlPathComponent.url(relativeTo: baseURL) else {
            throw NetworkRequestError.invalidURL
        }
         
        guard let body = try? JSONSerialization.data(withJSONObject: bodyParameters ?? [:], options: []) else {
            throw NetworkRequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpBody = body
        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
