//
//  Collection.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

extension Collection {

    /// Returns element if exists in the collection
    /// Usage: collection[safe: index]
    ///
    /// - Parameter index: Index of the element
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
