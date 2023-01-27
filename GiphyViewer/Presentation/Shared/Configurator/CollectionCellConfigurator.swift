//
//  CollectionCellConfigurator.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

struct CollectionCellConfigurator<CellType: Configurable, Model>: CollectionCellConfiguratorProtocol
where CellType.Model == Model, CellType: UICollectionViewCell {
    
    static var reuseId: String { return String(describing: CellType.self) }
    
    let item: Model?
    var size: CGSize
    
    init(item: Model?, size: CGSize) {
        self.item = item
        self.size = size
    }
    
    func configure(cell: UIView) {
        guard let item = item else { return }
        (cell as? CellType)?.configure(with: item)
    }
    
    func associatedValue<T>() -> T? {
        return item as? T
    }
}
