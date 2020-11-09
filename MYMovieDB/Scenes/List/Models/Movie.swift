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
        case overview
        case hasVideo = "video"
        case rating = "vote_average"
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

    /// Backdrop image path
    let backdropPath: String?

    /// Overview info
    let overview: String?

    /// Indicates if movie has a video
    let hasVideo: Bool?

    /// Rating
    let rating: Double?
}
