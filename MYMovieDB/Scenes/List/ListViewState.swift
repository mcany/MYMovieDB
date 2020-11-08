//
//  ListViewState.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

typealias ListViewStateOnChange = ((ListViewState.Change) -> Void)

final class ListViewState {

    /// State changes
    enum Change {
        case loading(Bool)
        case movies([Movie]?)
        case selectedMovieID(Int)
    }

    /// On change listener function
    var onChange: ListViewStateOnChange?

    /// Loading state of the view
    var loading = false {
        didSet {
            onChange?(.loading(loading))
        }
    }

    /// Movie list of the view
    var movies: [Movie]? {
        didSet {
            onChange?(.movies(movies))
        }
    }

    /// Movie list of the view
    var selectedMovie: Movie? {
        didSet {
            guard let movie = selectedMovie else {
                return
            }
            onChange?(.selectedMovieID(movie.identifier))
        }
    }
}
