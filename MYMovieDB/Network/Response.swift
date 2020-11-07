//
//  Response.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

/// URL response wrapper
struct Response {

    /// Data returned by the server
    let data: Data?

    /// HTTP status code of the receiver
    let statusCode: Int?

    /// Dictionary containing all the HTTP header fields of the receiver
    let allHeaderFields: [AnyHashable: Any]?

    /// HTTP error received by the response
    let error: Error?
}
