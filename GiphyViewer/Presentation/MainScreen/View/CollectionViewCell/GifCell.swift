//
//  GifCell.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit
import SDWebImage
import SnapKit

protocol GiffCellProtocol {
    var coverImageView: SDAnimatedImageView { get }
}

final class GifCell: UICollectionViewCell, GiffCellProtocol {
    
    var coverImageView: SDAnimatedImageView {
        imageView
    }
    
    private let imageView = SDAnimatedImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.stopAnimating()
        imageView.image = nil
    }
    
    private func setupLayout() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GifCell: Configurable {
    
    struct Model {
        let gifUrl: String
    }
    
    func configure(with model: Model) {
        imageView.sd_imageIndicator = LoadingIndicator()
        imageView.sd_setImage(with: URL(string: model.gifUrl))
        imageView.startAnimating()
    }
}
