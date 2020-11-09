//
//  ListViewData.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

protocol ListViewData {

    /// Identifier
    var identifier: Int { get }

    /// Name
    var name: String? { get }

    /// Image path
    var imagePath: String? { get }

    /// Media type
    var mediaType: MediaType? { get }

    /// Release date
    var releaseDate: String? { get }
}

extension ListViewData {

    var releaseDate: String? {
        return nil
    }
}
