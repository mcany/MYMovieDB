//
//  Network.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

// MARK: - Typealiases

typealias JSONDictionary = [String: Any]
typealias StringDictionary = [String: String]
typealias NetworkCompletion = (Response) -> Void

enum HTTPHeader {

    enum ContentType {

        static let key = "Content-Type"
        static let value = "application/json"
    }
}

enum QueryParameter {

    static let apiKey = "api_key"
}
