//
//  GifDetail.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 27.01.2023.
//

import Foundation

struct GifDetailData: Codable {
    let data: GifDetail
}

struct GifDetail: Codable {
    
    let id: String
    let url: String
    let images: Image
    
    struct Image: Codable {
        let previewGif: PreviewGif?
        let original: OriginalGif
        
        private enum CodingKeys: String, CodingKey {
            case previewGif = "preview_gif"
            case original
        }
    }
}
