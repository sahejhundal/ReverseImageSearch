//
//  KnowledgeGraphModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct KnowledgeGraphModel: Codable{
    let title: String
    let type: String
    let image: String
    let description: String
    let source: KnowledgeGraphModel.Source
    let born: String
    let height: String
    let net_worth: String
    let spouse: String
    let spouse_links: [KnowledgeGraphModel.Link]
    let children: String
    let children_links: [KnowledgeGraphModel.Link]
    let education: String
    let education_links: [KnowledgeGraphModel.Link]
    let profiles: [KnowledgeGraphModel.Profile]
    let people_also_search_for: [KnowledgeGraphModel.PeopleAlsoSearchFor]
    let people_also_search_for_link: String
    let people_also_search_for_stick: String
    enum CodingKeys: String, CodingKey {
        case title
        case type
        case image
        case description
        case source
        case born
        case height
        case net_worth
        case spouse
        case spouse_links
        case children
        case children_links
        case education
        case education_links
        case profiles
        case people_also_search_for
        case people_also_search_for_link
        case people_also_search_for_stick
    }
}

extension KnowledgeGraphModel{
    struct Source: Codable{
        let name: String
        let link: String
        enum CodingKeys: String, CodingKey {
            case name
            case link
        }
    }
    
    struct Link: Codable{
        let text: String
        let link: String
        enum CodingKeys: String, CodingKey {
            case text
            case link
        }
    }
    
    struct Profile: Codable{
        let name: String
        let link: String
        let source: String
        let image: String
        enum CodingKeys: String, CodingKey {
            case name
            case link
            case source
            case image
        }
    }
    
    struct PeopleAlsoSearchFor: Codable{
        let name: String
        let extensions: [String]?
        let link: String
        let source: String
        let image: String
        enum CodingKeys: String, CodingKey {
            case name
            case extensions
            case link
            case source
            case image
        }
    }
}
