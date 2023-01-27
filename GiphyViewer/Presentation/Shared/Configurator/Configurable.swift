//
//  Configurable.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
