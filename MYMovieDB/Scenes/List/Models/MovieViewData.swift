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
final class MovieViewData {

    private let movie: Movie

    private let releaseDateDate: Date?

    var title: String? {
        return movie.title
    }

    var releaseDate: String? {
        return releaseDateDate?.toString()
    }

    var posterPath: String? {
        return movie.posterPath
    }

    var backdropPath: String? {
        return movie.backdropPath
    }

    var overview: String? {
        return movie.overview
    }

    init(movie: Movie) {
        self.movie = movie
        releaseDateDate = movie.releaseDateString?.toDate(using: "yyyy-MM-dd")
    }
}
