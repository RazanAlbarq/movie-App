// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let video = try? newJSONDecoder().decode(Video.self, from: jsonData)

import Foundation

// MARK: - Video
struct Video: Codable {
    let id: Int?
    let results: [VideoPlayer]?
}

// MARK: - Result
struct VideoPlayer: Codable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
