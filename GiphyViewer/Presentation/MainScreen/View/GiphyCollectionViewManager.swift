//
//  GiphyCollectionViewManager.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

protocol GiphyCollectionViewManagerDelegate: AnyObject {
    func loadMoreGifs()
    func didSelectItem(at index: Int, cell: GiffCellProtocol?)
}

protocol GiphyCollectionViewManagerInput {
    func setup(collectionView: UICollectionView)
    func update(with viewModel: GiphyViewModel)
}


final class GiphyCollectionViewManager: NSObject {
    
    weak var delegate: GiphyCollectionViewManagerDelegate?
    private weak var collectionView: UICollectionView?
    private var viewModel: GiphyViewModel?
    
    private func updateTableView(with viewModel: GiphyViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
}

extension GiphyCollectionViewManager: GiphyCollectionViewManagerInput {
    
    func setup(collectionView: UICollectionView) {
        (collectionView.collectionViewLayout as? PinterestLayout)?.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GifCell.self, forCellWithReuseIdentifier: String(describing: GifCell.self))
        self.collectionView = collectionView
    }
    
    func update(with viewModel: GiphyViewModel) {
        updateTableView(with: viewModel)
    }
}

extension GiphyCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.sections[safe: section]?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let row = viewModel?.sections[safe: indexPath.section]?.rows[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.reuseId, for: indexPath)
        row.configurator.configure(cell: cell)
        return cell
    }
}

extension GiphyCollectionViewManager: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.row, cell: collectionView.cellForItem(at: indexPath) as? GiffCellProtocol)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let rows = viewModel?.sections[safe: indexPath.section]?.rows else { return }
        if indexPath.row >= rows.count - 20 {
            delegate?.loadMoreGifs()
        }
    }
}

extension GiphyCollectionViewManager: PinterestLayoutDelegate {
    
    func numberOfItemsInCollectionView() -> Int {
        viewModel?.sections[safe: 0]?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let row = viewModel?.sections[safe: indexPath.section]?.rows[safe: indexPath.row] else {
            return 0.0
        }
        return row.configurator.size.height
    }
}
