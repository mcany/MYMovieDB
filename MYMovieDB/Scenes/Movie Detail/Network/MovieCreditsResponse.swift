//
//  MovieCreditsResponse.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct MovieCreditsResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case casts = "cast"
    }

    /// Identifier
    let identifier: Int?

    /// Movie cast list
    let casts: [Cast]
}
