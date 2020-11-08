//
//  MovieDetailViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

protocol MovieDetailViewProtocol {

    /// State change handler to handle changes
    var stateChangeHandler: MovieDetailViewStateOnChange? { get set }

    /// Fetches movie detail
    func fetchMovieDetail()

}
