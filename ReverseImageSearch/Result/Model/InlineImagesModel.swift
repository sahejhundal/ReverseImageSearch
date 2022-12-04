//
//  InlineImagesModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct InlineImagesModel: Codable, Identifiable{
    let id = UUID()
    let link: String
    let source: String
    let thumbnail: String
    enum CodingKeys: String, CodingKey {
        case link
        case source
        case thumbnail
    }
}
