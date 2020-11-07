//
//  ListViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

protocol ListViewProtocol {

    /// State change handler to handle changes
    var stateChangeHandler: ListViewStateOnChange? { get set }

    /// Fetches movies
    func fetchMovies()
}
