//
//  AppRouter.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class AppRouter {

    private var window: UIWindow!

    func initialize() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let controller = ListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController

        window.makeKeyAndVisible()
    }
}
