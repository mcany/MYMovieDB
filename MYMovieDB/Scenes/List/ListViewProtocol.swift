//
//  ListViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

protocol ListViewProtocol {

    /// State change handler to handle changes
    var stateChangeHandler: ListViewStateOnChange? { get set }

    /// Number of movies in the view
    var movieCount: Int { get }

    /// Returns movie at given index if any
    /// - Parameter index: Index number of the movie
    func movie(at index: Int) -> MovieViewData?

    /// Fetches movies
    func fetchMovies()
}
