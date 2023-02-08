// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let people = try? newJSONDecoder().decode(People.self, from: jsonData)

import Foundation

// MARK: - People
struct People: Codable {
    let page: Int?
    let results: [Result1]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result1: Codable {
    let adult: Bool?
    let id: Int?
    let name, originalName: String?
    let mediaType: ResultMediaType?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: KnownForDepartment?
    let profilePath: String?
    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case adult, id, name
        case originalName = "original_name"
        case mediaType = "media_type"
        case popularity, gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: KnownForMediaType?
    let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum KnownForMediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case it = "it"
    case ja = "ja"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
}

enum ResultMediaType: String, Codable {
    case person = "person"
}

