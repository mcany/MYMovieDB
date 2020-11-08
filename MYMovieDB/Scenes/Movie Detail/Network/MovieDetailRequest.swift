//
//  MovieDetailRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

final class MovieDetailRequest: Request {

    private enum Parameter {

        static let movieID = "movie_id"
        static let baseEndpoint = "movie"
    }

    let endpoint: String

    let method: HTTPMethod = .get

    /// Inits request with given move ID parameter
    /// - Parameter movieID: Movie ID
    init(movieID: Int) {

        self.endpoint = "\(Parameter.baseEndpoint)/\(movieID)"
    }
}
