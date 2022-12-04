//
//  ImageResultsModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct ImageResultsModel: Codable, Identifiable{
    let id = UUID()
    let position: Int
    let title: String
    let link: String
    let thumbnail: String?
    let displayed_link: String
    let date: String?
    let snippet: String?
    let snippet_highlighted_words: [String]?
    let cached_page_link: String?
    let related_pages_link: String?
    enum CodingKeys: String, CodingKey {
        case position
        case title
        case link
        case thumbnail
        case displayed_link
        case date
        case snippet
        case snippet_highlighted_words
        case cached_page_link
        case related_pages_link
    }
}
