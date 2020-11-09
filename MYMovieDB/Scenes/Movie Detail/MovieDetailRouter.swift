//
//  MovieDetailRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

final class MovieDetailRouter: MovieDetailRouting {

    func proceedToPersonDetail(current: UINavigationController, personID: Int) {
        let dataController = PersonDetailDataController()
        let viewModel = PersonDetailViewModel(with: personID, dataController: dataController)
        let controller = PersonDetailViewController(with: viewModel)

        current.pushViewController(controller, animated: true)
    }
}
