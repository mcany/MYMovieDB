//
//  MoviePopularListRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

final class MoviePopularListRequest: Request {

    private enum Parameter {

        enum Key {

            static let language = "language"
            static let page = "page"
        }

        enum Value {

            static let english = "en-US"
        }
    }

    let endpoint: String = "movie/popular"

    let method: HTTPMethod = .get

    let queryParameters: StringDictionary?

    /// Inits request with given page parameter
    /// - Parameter page: Determines which page to request
    init(page: Int) {

        self.queryParameters = [
            Parameter.Key.language: Parameter.Value.english,
            Parameter.Key.page: "\(page)"
        ]
    }
}
