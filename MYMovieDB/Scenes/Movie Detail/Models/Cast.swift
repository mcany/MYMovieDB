//
//  Cast.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct Cast: Codable {

    private enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender
        case identifier = "id"
        case name
        case profilePath = "profile_path"
    }

    /// Cast id
    let castID: Int?

    /// Character name
    let character: String?

    /// Credit id
    let creditID: String?

    /// Gender
    let gender: Int?

    /// Identifier
    let identifier: Int?

    /// Name
    let name: String?

    let profilePath: String?
}
