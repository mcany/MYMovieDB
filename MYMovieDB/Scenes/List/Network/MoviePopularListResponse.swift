//
//  MoviePopularListResponse.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

struct MoviePopularListResponse: Decodable {

    private enum CodingKeys: String, CodingKey {

        case page
        case pages = "total_pages"
        case movies = "results"
    }

    /// Current page number
    let page: Int?

    /// Total page number
    let pages: Int?

    /// Current page movie list
    let movies: [Movie]?
}
