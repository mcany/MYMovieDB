//
//  SearchMultiResponse.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct SearchMultiResponse: Decodable {

    private enum CodingKeys: String, CodingKey {

        case results
    }

    /// Results of the search
    let results: [Result]
}
