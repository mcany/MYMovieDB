//
//  MovieDetailViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

protocol MovieDetailViewProtocol {

    /// Number of casts in the movie
    var castCount: Int { get }

    var casts: [Cast] { get }

    /// Returns cast at given index if any
    /// - Parameter index: Index number of the cast
    func cast(at index: Int) -> Cast?

    /// State change handler to handle changes
    var stateChangeHandler: MovieDetailViewStateOnChange? { get set }

    /// Selects cast at given index
    /// - Parameter index: Index of the selected cast
    func selectCast(at index: Int)

    /// Fetches movie detail
    func fetchMovieDetail()

}
