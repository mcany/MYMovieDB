//
//  AppRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class AppRouter {

    private var window: UIWindow!

    /// Initializes app window with root view controller
    func initialize() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewModel = ListViewModel(with: ListViewDataController())
        let controller = ListViewController(with: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController

        window.makeKeyAndVisible()
    }
}
