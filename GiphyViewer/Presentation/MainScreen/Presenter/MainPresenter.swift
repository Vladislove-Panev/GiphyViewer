//
//  MainPresenter.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol MainPresenterInput: AnyObject {
    func viewDidLoad()
}

final class MainPresenter {
 
    private let service: GiphyServiceInput
    private weak var view: MainViewControllerInput?
    private let dataConverter: MainDataConverterInput
    private var model: [GifDetail] = []
    private var isLoading = false
    private var limit = 40
    
    init(
        service: GiphyServiceInput,
        view: MainViewControllerInput,
        dataConverter: MainDataConverterInput
    ) {
        self.service = service
        self.view = view
        self.dataConverter = dataConverter
    }
    
    private func assembleViewModel() -> GiphyViewModel {
        return dataConverter.convert(with: model)
    }
}

extension MainPresenter: GiphyCollectionViewManagerDelegate {
    
    func didSelectItem(at index: Int, cell: GiffCellProtocol?) {
        view?.didSelect(item: model[index], cell: cell)
    }
    
    func loadMoreGifs() {
        if !isLoading {
            service.getTrendingGifs(with: limit, offset: model.count)
            isLoading = true
        }
    }
}

extension MainPresenter: MainPresenterInput {
    func viewDidLoad() {
        view?.showPreloaderView()
        service.getTrendingGifs(with: limit, offset: model.count)
        isLoading = true
    }
}

extension MainPresenter: GiphyServiceOutput {
    
    func didGetTrends(trends: GiphyTrending) {
        model.append(contentsOf: trends.data)
        view?.update(with: assembleViewModel())
        isLoading = false
        view?.hidePreloaderView()
    }
    
    func didFailedGetTrends(error: Error) {
        view?.showErrorAlert(error: error)
        isLoading = false
        view?.hidePreloaderView()
    }
}
