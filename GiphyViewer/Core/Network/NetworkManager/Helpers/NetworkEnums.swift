//
//  NetworkEnums.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}
