//
//  Movie.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

final class Movie: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case posterPath = "poster_path"
    }

    /// Identifier
    let identifier: Int

    /// Title
    let title: String?

    /// Poster path
    let posterPath: String?
}
