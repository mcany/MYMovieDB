//
//  MovieViewData.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import Foundation

/**
 Represents a `Movie` object displayed on the user interface
 */
final class MovieViewData: ListViewData {

    private let movie: Movie

    private let releaseDateDate: Date?

    var identifier: Int {
        return movie.identifier
    }

    var name: String? {
        return movie.title
    }

    var releaseDate: String? {
        return releaseDateDate?.toString()
    }

    var imagePath: String? {
        return movie.posterPath
    }

    var backdropPath: String? {
        return movie.backdropPath
    }

    var overview: String? {
        return movie.overview
    }

    var hasVideo: Bool {
        return movie.hasVideo ?? false
    }

    var rating: String {
        guard let rating = movie.rating else {
            return "-"
        }
        return String(rating)
    }

    var mediaType: MediaType? {
        return .movie
    }

    init(movie: Movie) {
        self.movie = movie
        releaseDateDate = movie.releaseDateString?.toDate(using: "yyyy-MM-dd")
    }
}
