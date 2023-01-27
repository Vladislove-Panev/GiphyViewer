//
//  GifDetailPresenter.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 27.01.2023.
//

import Foundation

protocol GifDetailPresenterInput: AnyObject {
    func viewDidLoad()
    func getGifStringLink() -> String
}

final class GifDetailPresenter {
    
    private let id: String
    private let service: GiphyServiceInput
    private let view: GifDetailViewInput
    private var viewModel: DetailViewModel?
    
    init(
        id: String,
        view: GifDetailViewInput,
        service: GiphyServiceInput
    ) {
        self.id = id
        self.view = view
        self.service = service
    }
}

extension GifDetailPresenter: GifDetailPresenterInput {
    
    func getGifStringLink() -> String {
        return viewModel?.url ?? ""
    }

    func viewDidLoad() {
        view.showPreloaderView()
        service.getGifBy(id: id)
    }
}

extension GifDetailPresenter: GiphyServiceOutput {
    
    func didGetDetail(detail: GifDetailData) {
        
        view.hidePreloaderView()
        
        guard let originalUrl = detail.data.images.original.url,
              let height = detail.data.images.original.height,
              let doubleHeight = Double(height),
              let width = detail.data.images.original.width,
              let doubleWidth = Double(width) else { return }
        
        viewModel = .init(
            id: detail.data.id,
            url: detail.data.url,
            hdImageUrl: originalUrl,
            height: CGFloat(doubleHeight),
            width: CGFloat(doubleWidth)
        )
        
        guard let viewModel = viewModel else { return }
        
        let aspectRatio = viewModel.height / viewModel.width
        
        view.setupLayout(with: aspectRatio, imageUrl: viewModel.hdImageUrl)
    }
    
    func didFailedGetDetail(error: Error) {
        view.hidePreloaderView()
        view.showErrorAlert(error: error)
    }
}
