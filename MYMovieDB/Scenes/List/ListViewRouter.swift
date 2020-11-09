//
//  ListViewRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class ListRouter: ListViewRouting {

    func proceedToItemDetail(current: UINavigationController,
                             mediaType: MediaType?,
                             itemID: Int) {

        var controller: ViewController!
        if mediaType == .person {
            controller = createPersonDetailVC(with: itemID)
        } else if mediaType == .movie {
            controller = createMovieDetailVC(with: itemID)
        } else {
            return
        }
        current.pushViewController(controller, animated: true)
    }
}

private extension ListRouter {

    func createMovieDetailVC(with itemID: Int) -> ViewController {

        let dataController = MovieDetailDataController()
        let viewModel = MovieDetailViewModel(with: itemID,
                                             dataController: dataController)
        let router = MovieDetailRouter()
        let controller = MovieDetailViewController(with: viewModel,
                                                   router: router)
        return controller
    }

    func createPersonDetailVC(with itemID: Int) -> ViewController {

        let dataController = PersonDetailDataController()
        let viewModel = PersonDetailViewModel(with: itemID,
                                              dataController: dataController)
        let controller = PersonDetailViewController(with: viewModel)

        return controller
    }
}
