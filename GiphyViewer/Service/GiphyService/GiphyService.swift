//
//  GiphyService.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol GiphyServiceInput {
    func getTrendingGifs(with limit: Int, offset: Int)
    func getGifBy(id: String)
}

protocol GiphyServiceOutput: AnyObject {
    func didGetTrends(trends: GiphyTrending)
    func didFailedGetTrends(error: Error)
    func didGetDetail(detail: GifDetailData)
    func didFailedGetDetail(error: Error)
}

final class GiphyService: GiphyServiceInput {
    
    weak var output: GiphyServiceOutput?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTrendingGifs(with limit: Int, offset: Int) {
        networkManager.request(endpoint: GiphyEndpoint.getTrends(limit: limit, offset: offset)) { [weak self] (result: Result<GiphyTrending, Error>) in
            switch result {
            case .success(let trends):
                self?.output?.didGetTrends(trends: trends)
            case .failure(let error):
                self?.output?.didFailedGetTrends(error: error)
            }
        }
    }
    
    func getGifBy(id: String) {
        networkManager.request(endpoint: GiphyEndpoint.getBy(id: id)) { [weak self] (result: Result<GifDetailData, Error>) in
            switch result {
            case .success(let detail):
                self?.output?.didGetDetail(detail: detail)
            case .failure(let error):
                self?.output?.didFailedGetDetail(error: error)
            }
        }
    }
}

extension GiphyServiceOutput {
    func didGetTrends(trends: GiphyTrending) { }
    func didFailedGetTrends(error: Error) { }
    func didGetDetail(detail: GifDetailData) { }
    func didFailedGetDetail(error: Error) { }
}
