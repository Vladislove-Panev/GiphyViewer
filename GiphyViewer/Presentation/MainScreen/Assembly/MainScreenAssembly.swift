//
//  MainScreenAssembly.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

final class MainScreenAssembly {
    static func assemblyModule() -> UINavigationController {
        
        let mainVC = MainViewController()
        
        let collectionViewManager = GiphyCollectionViewManager()
        
        // let router = ProductDetailRouter(view: view)
        let networkManager = SimpleNetworkManager()
        let giphyService = GiphyService(networkManager: networkManager)
        let trendView = TrendView(collectionViewManager: collectionViewManager)
        let dataConverter = MainDataConverter()
        let transitionManager = TransitionManager(duration: 0.8)
        
        let presenter = MainPresenter(
            service: giphyService,
            view: mainVC,
            dataConverter: dataConverter
        )
        giphyService.output = presenter

        collectionViewManager.delegate = presenter
        mainVC.presenter = presenter
        mainVC.trendView = trendView
        mainVC.transitionManager = transitionManager
        
        let navVC = UINavigationController(rootViewController: mainVC)
        navVC.delegate = transitionManager
        
        return navVC
    }
}
