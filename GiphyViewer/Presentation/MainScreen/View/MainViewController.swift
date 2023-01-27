//
//  MainViewController.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

protocol MainViewControllerInput: PreloaderViewPresentable {
    func update(with viewModel: GiphyViewModel)
    func showErrorAlert(error: Error)
    func didSelect(item: GifDetail, cell: GiffCellProtocol?)
}

final class MainViewController: UIViewController {
    
    var loadingCounter = 0
    var presenter: MainPresenterInput?
    var transitionManager: TransitionManager?
    var trendView: TrendViewInput?
    var presentingCell: GiffCellProtocol?
    
    
    override func loadView() {
        super.loadView()
        view = trendView as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        presenter?.viewDidLoad()
    }
}

extension MainViewController: MainViewControllerInput {
    
    func update(with viewModel: GiphyViewModel) {
        trendView?.update(with: viewModel)
    }
    
    func showErrorAlert(error: Error) {
        let alertVC = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let oneMoreAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
            self?.presenter?.viewDidLoad()
        })
        alertVC.addAction(oneMoreAction)
        
        present(alertVC, animated: true)
    }
    
    func didSelect(item: GifDetail, cell: GiffCellProtocol?) {
        guard let selectedCell = cell as? GifCell,
        let selectedCellSuperview = selectedCell.superview else { return }
        presentingCell = cell
        transitionManager?.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transitionManager?.originFrame = CGRect(
            x: (transitionManager?.originFrame.origin.x ?? 0.0) + 20,
            y: (transitionManager?.originFrame.origin.y ?? 0.0) + 20,
          width: (transitionManager?.originFrame.size.width ?? 0) - 40,
            height: (transitionManager?.originFrame.size.height ?? 0.0) - 40
        )

        transitionManager?.presenting = true
        guard let detailVC = GifDetailAssembly.assemblyModule(with: item) else { return }
        detailVC.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController {
    
    func assemblyModule() {
        
        let collectionViewManager = GiphyCollectionViewManager()
        
        let networkManager = SimpleNetworkManager()
        let giphyService = GiphyService(networkManager: networkManager)
        let trendView = TrendView(collectionViewManager: collectionViewManager)
        let dataConverter = MainDataConverter()
        
        let presenter = MainPresenter(
            service: giphyService,
            view: self,
            dataConverter: dataConverter
        )
        giphyService.output = presenter

        collectionViewManager.delegate = presenter
        self.presenter = presenter
        self.trendView = trendView
    }
}
