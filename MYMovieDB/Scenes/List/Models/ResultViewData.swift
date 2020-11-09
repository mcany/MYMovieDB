//
//  ResultViewData.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

/**
 Represents a `Result` object displayed on the user interface
 */
final class ResultViewData: ListViewData {

    private let result: Result

    var name: String? {
        if let name = result.name {
            return name
        }
        return result.title
    }

    var imagePath: String? {
        if let imagePath = result.profilePath {
            return imagePath
        }
        return result.posterPath
    }

    var mediaType: MediaType? {
        result.mediaType
    }

    init(result: Result) {
        self.result = result
    }
}
