//
//  UIActivityIndicatorView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

extension UIActivityIndicatorView {

    private enum Constant {

        static let cornerRadius: CGFloat = 10
    }

    func applyStyling() {
        layer.cornerRadius = Constant.cornerRadius
        hidesWhenStopped = true
        style = .whiteLarge
        backgroundColor = Theme.NavigationBar.background
    }
}
