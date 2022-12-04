//
//  ImageSizesModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct ImageSizesModel: Codable{
    let title: String
    let link: String
    let serpapi_link: String
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case serpapi_link
    }
}
