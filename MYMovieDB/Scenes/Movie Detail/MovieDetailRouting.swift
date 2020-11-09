//
//  MovieDetailRouting.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

protocol MovieDetailRouting {

    /// Proceeds to person detail page
    /// - Parameters:
    ///   - current: Current context
    ///   - personID: Selected movie id
    func proceedToPersonDetail(current: UINavigationController, personID: Int)

}
