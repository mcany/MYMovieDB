//
//  MovieDetailDataProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

typealias FetchMovieDetailCompletion = ((Movie?, Error?) -> Void)

protocol MovieDetailDataProtocol {

    /// Fetces movie detail of the given id
    /// - Parameters:
    ///   - movieID: ID of the requested movie
    ///   - completion: Completion block
    func fetchMovieDetail(movieID: Int, completion: @escaping FetchMovieDetailCompletion)
}
