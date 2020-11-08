//
//  ListViewRouting.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

protocol ListViewRouting {

    /// Proceeds to movie detail page
    /// - Parameters:
    ///   - current: Current context
    ///   - movieID: Selected movie id
    func proceedToMovieDetail(current: UINavigationController, movieID: Int)

}
