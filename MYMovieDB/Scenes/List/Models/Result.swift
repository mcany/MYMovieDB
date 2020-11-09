//
//  Result.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

enum MediaType: String, Codable, CaseIterable {

    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

// MARK: - Result
struct Result: Codable {

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case name
        case id
        case posterPath = "poster_path"
        case title
        case profilePath = "profile_path"
    }

    let mediaType: MediaType?
    let name: String?
    let id: Int
    let posterPath: String?
    let title: String?
    let profilePath: String?
}
