//
//  Request.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

protocol Request {

    /// Endpoint value
    var endpoint: String { get }

    /// HTTP method
    var method: HTTPMethod { get }

    /// Query parameters of the request
    /// Will be added at the end of the URL  after a question mark (?) and  separated by ampersands (&)
    var queryParameters: StringDictionary? { get }

    /// Body parameters of the request
    var bodyParameters: JSONDictionary? { get }
}

extension Request {

    var queryParameters: StringDictionary? {
        return nil
    }

    var bodyParameters: JSONDictionary? {
        return nil
    }
}
