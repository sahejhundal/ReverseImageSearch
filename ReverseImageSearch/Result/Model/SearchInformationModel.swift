//
//  SearchInformationModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct SearchInformationModel: Codable{
    let organic_results_state: String
    let query_displayed: String
    let total_results: Int?
    let time_taken_displayed: Double?
    enum CodingKeys: String, CodingKey{
        case organic_results_state
        case query_displayed
        case time_taken_displayed
        case total_results
    }
}
