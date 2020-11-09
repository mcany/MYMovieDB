//
//  Reusable.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

protocol Reusable where Self: UIView {

    static var reuseID: String { get }
}

extension Reusable {

    static var reuseID: String {
        return NSStringFromClass(self)
    }
}
