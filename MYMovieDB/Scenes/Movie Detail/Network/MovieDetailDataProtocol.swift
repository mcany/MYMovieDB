//
//  MovieDetailDataProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

typealias FetchMovieDetailCompletion = ((Movie?, Error?) -> Void)

typealias FetchMovieCreditCompletion = ((MovieCreditsResponse?, Error?) -> Void)

protocol MovieDetailDataProtocol {

    /// Fetches movie detail of the given id
    /// - Parameters:
    ///   - movieID: ID of the requested movie
    ///   - completion: Completion block
    func fetchMovieDetail(movieID: Int, completion: @escaping FetchMovieDetailCompletion)

    /// Fetches movie credits
    /// - Parameters:
    ///   - movieID: ID of the requested movie
    ///   - completion: Completion block
    func fetchMovieCredits(movieID: Int, completion: @escaping FetchMovieCreditCompletion)
}
