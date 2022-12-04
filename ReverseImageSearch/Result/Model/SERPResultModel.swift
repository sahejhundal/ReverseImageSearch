//
//  SERPResultModel.swift
//  JsonParser
//
//  Created by DON on 11/21/22.
//

import Foundation

struct ResultModel: Codable{
    var search_metadata: SearchMetadata
    var search_information: SearchInformationModel?
    var image_sizes: [ImageSizesModel]?
    var inline_images: [InlineImagesModel]?
    var inline_images_link: String?
    var inline_images_serpapi_link: String?
    var image_results: [ImageResultsModel]?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case search_metadata
        case search_information
        case image_sizes
        case inline_images
        case inline_images_link
        case inline_images_serpapi_link
        case image_results
        case error
    }
}

extension ResultModel{
    static var new = ResultModel(search_metadata: SearchMetadata(id: "", status: ""), search_information: SearchInformationModel(organic_results_state: "", query_displayed: "query displayed", total_results: 0, time_taken_displayed: 0), image_sizes: [], inline_images: [], inline_images_link: "", inline_images_serpapi_link: "", image_results: [], error: "")
}
