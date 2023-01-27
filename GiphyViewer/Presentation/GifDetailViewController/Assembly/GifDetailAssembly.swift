//
//  GifDetailAssembly.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 27.01.2023.
//

import UIKit

final class GifDetailAssembly {
    static func assemblyModule(with model: GifDetail) -> UIViewController? {
        
        let detailVC = GifDetailViewController()
        let networkManager = SimpleNetworkManager()
        let service = GiphyService(networkManager: networkManager)
        let presenter = GifDetailPresenter(id: model.id, view: detailVC, service: service)
        service.output = presenter
        
        detailVC.presenter = presenter
        
        return detailVC
    }
}
