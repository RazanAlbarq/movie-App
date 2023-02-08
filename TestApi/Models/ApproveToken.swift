// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let approveToken = try? JSONDecoder().decode(ApproveToken.self, from: jsonData)

import Foundation

// MARK: - ApproveToken
struct ApproveToken: Codable {
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
