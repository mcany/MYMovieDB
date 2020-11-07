//
//  UINavigationBar.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

extension UINavigationBar {

    func applyStyling() {

        isTranslucent = false
        barTintColor = Theme.NavigationBar.background
        tintColor = Theme.NavigationBar.label

        let foregroundColor = Theme.NavigationBar.label
        titleTextAttributes = [.foregroundColor: foregroundColor]
    }
}
