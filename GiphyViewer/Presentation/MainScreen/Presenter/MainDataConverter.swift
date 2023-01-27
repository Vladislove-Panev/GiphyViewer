//
//  MainDataConverter.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

protocol MainDataConverterInput {
    func convert(with model: [GifDetail]) -> GiphyViewModel
}


final class MainDataConverter {
    
    private typealias Row = GiphyViewModel.Section.Row
    private typealias Section = GiphyViewModel.Section
    
    private typealias GifCellConfigurator = CollectionCellConfigurator<
        GifCell,
        GifCell.Model
    >
    
    private func assembleGifSection(
        with model: [GifDetail]
        // delegate: AnyObject?
    ) -> Section {
        
        var rows: [Row] = []
        
        typealias GiffCellModel = GifCell.Model
        
        for element in model {
            let gifModel = GiffCellModel(gifUrl: element.images.previewGif?.url ?? "")
            let size = CGSize(
                width: Double(element.images.previewGif?.width ?? "0") ?? 0.0,
                height: Double(element.images.previewGif?.height ?? "0") ?? 0.0
            )
            let gifCell = Row(configurator: GifCellConfigurator(item: gifModel, size: size))
            rows.append(gifCell)
        }
        
        return Section(rows: rows)
    }
}


// MARK: - ProductDetailDataConverterInput
extension MainDataConverter: MainDataConverterInput {
    
    func convert(with model: [GifDetail]) -> GiphyViewModel {
        
        var sections: [Section] = []
        
        let gifSection = assembleGifSection(with: model)
        sections.append(gifSection)
        
        return GiphyViewModel(sections: sections)
    }
}
