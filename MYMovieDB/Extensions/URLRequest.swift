//
//  URLRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

extension URLRequest {

    init(with url: URL,
         method: HTTPMethod,
         queryParameters: StringDictionary?,
         bodyParameters: JSONDictionary?,
         headers: StringDictionary?) {

        // Append querystring to URL
        var actualURL = url
        if let queryParameters = queryParameters,
           var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            components.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            if let componentsURL = components.url {
                actualURL = componentsURL
            }
        }

        self.init(url: actualURL)
        httpMethod = method.rawValue

        // Add any body JSON parameters for POST requests
        if let bodyParameters = bodyParameters {
            setValue(HTTPHeader.ContentType.value,
                     forHTTPHeaderField: HTTPHeader.ContentType.key)
            httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }

        // Add extra headers
        headers?.forEach { addValue($1, forHTTPHeaderField: $0) }
    }
}
