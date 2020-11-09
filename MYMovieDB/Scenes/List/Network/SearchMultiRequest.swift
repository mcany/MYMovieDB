//
//  SearchMultiRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct SearchMultiRequest: Request {

    private enum Parameter {

        static let query = "query"
    }

    let endpoint: String = "search/multi"

    let method: HTTPMethod = .get

    let queryParameters: StringDictionary?

    /// Inits request with given query parameter
    /// - Parameter query: Determines which query to search
    init(query: String) {

        self.queryParameters = [
            Parameter.query: query
        ]
    }
}
