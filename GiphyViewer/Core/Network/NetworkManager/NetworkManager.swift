//
//  NetworkManager.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol NetworkManager {
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}
