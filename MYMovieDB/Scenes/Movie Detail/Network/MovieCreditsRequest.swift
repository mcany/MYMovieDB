//
//  MovieCreditsRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

final class MovieCreditsRequest: Request {

    private enum Parameter {

        static let movieID = "movie_id"
        static let baseEndpoint = "movie"
        static let endEndpoint = "credits"
    }

    let endpoint: String

    let method: HTTPMethod = .get

    /// Inits request with given move ID parameter
    /// - Parameter movieID: Movie ID
    init(movieID: Int) {

        self.endpoint = "\(Parameter.baseEndpoint)/\(movieID)/\(Parameter.endEndpoint)"
    }
}
