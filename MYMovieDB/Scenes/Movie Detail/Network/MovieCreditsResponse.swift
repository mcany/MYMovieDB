//
//  MovieCreditsResponse.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

final class MovieCreditsResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case casts = "cast"
    }

    let identifier: Int?

    let casts: [Cast]
}
