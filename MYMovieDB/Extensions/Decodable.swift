//
//  Decodable.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

extension Decodable {

    /// Creates an instance with given JSON string
    ///
    /// - Parameter json: JSON string as source
    /// - Returns: An instance of `Self` and `nil` if conversion fails.
    static func model(withJSONString json: String?) -> Self? {
        let data = json?.data(using: .utf8)
        return model(withJSONData: data)
    }

    /// Creates an instance with given JSON dictionary
    ///
    /// - Parameter json: JSON dictionary as source
    /// - Returns: An instance of `Self` and `nil` if conversion fails.
    static func model(withJSONDictinoary json: Any) -> Self? {
        guard JSONSerialization.isValidJSONObject(json) else {
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return decode(data)
        } catch {
            return nil
        }
    }

    /// Creates an instance with given JSON data
    ///
    /// - Parameter data: JSON data as source
    /// - Returns: An instance of `Self` and `nil` if conversion fails.
    static func model(withJSONData data: Data?) -> Self? {
        guard let data = data else {
            return nil
        }
        return decode(data)
    }

    private static func decode(_ data: Data) -> Self? {
        do {
            let object = try JSONDecoder().decode(Self.self, from: data)
            return object
        } catch {
            return nil
        }
    }
}
