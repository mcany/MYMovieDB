//
//  ListViewDataProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

typealias FetchMoviesCompletion = ((MoviePopularListResponse?, Error?) -> Void)

protocol ListViewDataProtocol {

    /// Fetches movie list with given parameters
    /// - Parameters:
    ///   - page: Page number to fetch
    ///   - completion: Completion block
    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion)
}
