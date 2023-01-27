//
//  GiphyViewModel.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import Foundation

struct GiphyViewModel {
    
    let sections: [Section]
    
    struct Section {
        
        let rows: [Row]
        
        struct Row {
            
            let configurator: CollectionCellConfiguratorProtocol
           
            var reuseId: String {
                return type(of: configurator).reuseId
            }
        }
    }
}
