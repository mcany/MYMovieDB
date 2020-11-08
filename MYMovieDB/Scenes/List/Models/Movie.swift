//
//  Movie.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

struct Movie: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case posterPath = "poster_path"
        case genres = "genre_ids"
        case releaseDateString = "release_date"
        case backdropPath = "backdrop_path"
    }

    /// Identifier
    let identifier: Int

    /// Title
    let title: String?

    /// Poster image path
    let posterPath: String?

    /// Genres
    let genres: [Int]?
    //
    /// Poster path
    let releaseDateString: String?

    /// Backdrop iamge path
    let backdropPath: String?

}
