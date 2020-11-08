//
//  ListViewRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class ListRouter: ListViewRouting {

    func proceedToMovieDetail(current: UINavigationController, movieID: Int) {
        let viewModel = MovieDetailViewModel(with: movieID)
        let controller = MovieDetailViewController(with: viewModel)

        current.pushViewController(controller, animated: true)
    }
}
