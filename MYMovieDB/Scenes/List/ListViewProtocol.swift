//
//  ListViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import Foundation

protocol ListViewProtocol {

    /// State change handler to handle changes
    var stateChangeHandler: ListViewStateOnChange? { get set }

    /// List segment count in the view
    var segmentCount: Int { get }

    /// Returns  list count in the view List count in the view
    /// - Parameter indexPath: Section
    func listCount(at section: Int) -> Int

    /// Returns list item at given index if any
    /// - Parameter indexPath: IndexPath number of the item
    func listItem(at indexPath: IndexPath) -> ListViewData?

    /// Returns segment title at given index if any
    /// - Parameter index: Index number of the item
    func segmentTitle(at index: Int) -> String?

    /// User selection index
    /// - Parameter indexPath: Index number of the selected item
    func selectListItem(at indexPath: IndexPath)

    /// Begins search with given keyword
    /// - Parameter keyword: Search keyword
    func search(with keyword: String?)

    /// Fetches movies
    func fetchMovies()
}
