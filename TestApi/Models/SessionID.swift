// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sessionID = try? JSONDecoder().decode(SessionID.self, from: jsonData)

import Foundation

// MARK: - NewSession
struct NewSession: Codable {
    let success: Bool?
    let sessionID: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
