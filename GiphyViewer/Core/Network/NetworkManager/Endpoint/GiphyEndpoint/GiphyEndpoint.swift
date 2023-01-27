//
//  GiphyEndpoint.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

enum GiphyEndpoint: Endpoint {

    case getTrends(limit: Int, offset: Int)
    case getBy(id: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.giphy.com"
        }
    }
    
    var path: String {
        switch self {
        case .getTrends:
            return "/v1/gifs/trending"
        case .getBy(let id):
            return "/v1/gifs/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getTrends(let limit, let offset):
            return [
                URLQueryItem(name: "api_key", value: Constants.giphyApiKey),
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        case .getBy:
            return [
                URLQueryItem(name: "api_key", value: Constants.giphyApiKey)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getTrends:
            return "GET"
        case .getBy:
            return "GET"
        }
    }
}
