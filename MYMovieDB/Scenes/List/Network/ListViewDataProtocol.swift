//
//  ListViewDataProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

typealias FetchMoviesCompletion = ((MoviePopularListResponse?, Error?) -> Void)

typealias SearchMultiCompletion = ((SearchMultiResponse?, Error?) -> Void)

protocol ListViewDataProtocol {

    /// Fetches movie list with given parameters
    /// - Parameters:
    ///   - page: Page number to fetch
    ///   - completion: Completion block
    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion)

    /// Searches with the given query
    /// - Parameters:
    ///   - query: Query keyword
    ///   - completion: Completion block
    func search(_ query: String, completion: @escaping SearchMultiCompletion)
}
