//
//  Endpoint.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
}
