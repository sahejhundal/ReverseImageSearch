//
//  KnowledgeGraphModel.swift
//  ReverseImageSearch
//
//  Created by DON on 11/21/22.
//

import Foundation

struct KnowledgeGraphModel: Codable{
    let title: String?
    let type: String?
    let image: String?
    let description: String?
    let source: KnowledgeGraphModel.Source?
    let organizations_founded: String?
    let born: String?
    let height: String?
    let net_worth: String?
    let spouse: String?
    let spouse_links: [KnowledgeGraphModel.Link]?
    let children: String?
    let children_links: [KnowledgeGraphModel.Link]?
    let education: String?
    let education_links: [KnowledgeGraphModel.Link]?
    let nominations: String?
    let profiles: [KnowledgeGraphModel.Profile]?
    let people_also_search_for: [KnowledgeGraphModel.PeopleAlsoSearchFor]?
    let people_also_search_for_link: String?
    let people_also_search_for_stick: String?
    enum CodingKeys: String, CodingKey {
        case title
        case type
        case image
        case description
        case source
        case organizations_founded
        case born
        case height
        case net_worth
        case spouse
        case spouse_links
        case children
        case children_links
        case education
        case education_links
        case nominations
        case profiles
        case people_also_search_for
        case people_also_search_for_link
        case people_also_search_for_stick
    }
}

extension KnowledgeGraphModel{
    static var elon = KnowledgeGraphModel(title: "Elon Musk", type: "Chief Executive Officer of Twitter", image: "https://serpapi.com/searches/638ac81c2bc7d8b1273f46e7/images/7c09e155eba57c345669003a950e08a718d13ed6a1ce76eb.jpeg", description: "Elon Reeve Musk FRS is a business magnate and investor. He is the founder, CEO and chief engineer of SpaceX; angel investor, CEO and product architect of Tesla, Inc.; founder of The Boring Company; co-founder of Neuralink and OpenAI; president of the Musk Foundation; and owner and CEO of Twitter, Inc.", source: Source(name: "Wikipedia", link: "https://en.wikipedia.org/wiki/Elon_Musk"), organizations_founded: "Tesla, Neuralink, MORE", born: "June 28, 1971 (age 51 years), Pretoria, South Africa", height: "", net_worth: "", spouse: "", spouse_links: [], children: "", children_links: [], education: "", education_links: [], nominations: "Shorty Award for Innovator of the Year, Global Energy Prize", profiles: [Profile(name: "Twitter", link: "https://twitter.com/elonmusk", source: "commontopic", image: "https://serpapi.com/searches/638ac81c2bc7d8b1273f46e7/images/7c09e155eba57c345669003a950e08a7e4c4c87d33f5777d25b45f9f653b66781ff52dd4b0737ead.png")], people_also_search_for: [], people_also_search_for_link: "", people_also_search_for_stick: "")
    
    
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
    
    struct Profile: Codable, Identifiable{
        let id = UUID()
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

