//
//  Theme.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

enum Theme {

    static let background = colorForUIStyle(dark: .blackRussian, any: .pattensBlue)

    static let label = colorForUIStyle(dark: .white100, any: .stone100)

    enum NavigationBar {

        static let background = colorForUIStyle(dark: Theme.background, any: .darkAquaBlue)

        static let label: UIColor = .white100
    }
}

extension Theme {

    static func colorForUIStyle(dark: UIColor, any: UIColor) -> UIColor {

        if #available(iOS 13.0, *) {
            return UIColor { (traitcollection: UITraitCollection) -> UIColor in
                if traitcollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return any
                }
            }
        } else {
            return any
        }
    }
}
