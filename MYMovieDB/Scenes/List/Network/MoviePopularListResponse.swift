//
//  MoviePopularListResponse.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

final class MoviePopularListResponse: Decodable {

    private enum CodingKeys: String, CodingKey {

        case page
        case pages = "total_pages"
        case results
    }

    /// Current page number
    let page: Int

    /// Total page number
    let pages: Int

    /// Current page movie list
    let movies: [Movie]?

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        movies = try container.decode([Movie].self, forKey: .results)
    }
}
