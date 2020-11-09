//
//  UIView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

extension UIView {

    /// Get subview of the view with a particular type
    /// - Parameter type: Subviews type
    /// - Returns: Subviews array
    func subViews<T: UIView>(type: T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }
}
