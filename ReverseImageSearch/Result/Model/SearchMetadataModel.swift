import Foundation

struct SearchMetadata: Codable{
    let id: String
    let status: String
    enum CodingKeys: String, CodingKey {
        case id
        case status
    }
}
