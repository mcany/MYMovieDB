//
//  ListViewRouting.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

protocol ListViewRouting {

    /// Proceeds to item detail page
    /// - Parameters:
    ///   - current: Current context
    ///   - mediaType: Media type of the selected item
    ///   - itemID: Selected item id
    func proceedToItemDetail(current: UINavigationController,
                             mediaType: MediaType?,
                             itemID: Int)
}
