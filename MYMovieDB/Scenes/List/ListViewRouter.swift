//
//  ListViewRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class ListRouter: ListViewRouting {

    func proceedToMovieDetail(current: UINavigationController, movieID: Int) {
        let dataController = MovieDetailDataController()
        let viewModel = MovieDetailViewModel(with: movieID, dataController: dataController)
        let router = MovieDetailRouter()
        let controller = MovieDetailViewController(with: viewModel,
                                                   router: router)

        current.pushViewController(controller, animated: true)
    }
}
