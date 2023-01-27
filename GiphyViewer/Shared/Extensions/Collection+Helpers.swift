//
//  Collection+Helpers.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
