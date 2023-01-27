//
//  TrendView.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit
import SnapKit

protocol TrendViewInput {
    func update(with viewModel: GiphyViewModel)
}

final class TrendView: UIView {
    
    private var collectionViewManager: GiphyCollectionViewManagerInput?
    
    private let collectionView: UICollectionView = {
        let pinterestLayout = PinterestLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: pinterestLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    convenience init(collectionViewManager: GiphyCollectionViewManagerInput) {
        
        self.init(frame: .zero)
        self.collectionViewManager = collectionViewManager
        collectionViewManager.setup(collectionView: collectionView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TrendView: TrendViewInput {
    
    func update(with viewModel: GiphyViewModel) {
        collectionViewManager?.update(with: viewModel)
    }
}
