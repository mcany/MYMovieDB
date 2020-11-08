//
//  MovieDetailViewState.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

typealias MovieDetailViewStateOnChange = ((MovieDetailViewState.Change) -> Void)

final class MovieDetailViewState {

    /// State changes
    enum Change {
        case loading(Bool)
        case movie(MovieViewData)
    }

    /// On change listener function
    var onChange: MovieDetailViewStateOnChange?

    /// Loading state of the view
    var loading = false {
        didSet {
            onChange?(.loading(loading))
        }
    }

    /// Movie data of the view
    var movie: MovieViewData? {
        didSet {
            guard let movie = movie else {
                return
            }
            onChange?(.movie(movie))
        }
    }
}
