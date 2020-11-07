//
//  AppDelegate.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let router = AppRouter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router.initialize()
        return true
    }
}
