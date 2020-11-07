//
//  UIView+Anchor.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

extension UIView {

    /// Returns safe area's leading anchor
    var my_leadingAnchor: NSLayoutXAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }

    /// Returns safe area's trailing anchor
    var my_trailingAnchor: NSLayoutXAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }

    /// Returns safe area's left anchor
    var my_leftAnchor: NSLayoutXAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        } else {
            return leftAnchor
        }
    }

    /// Returns safe area's right anchor
    var my_rightAnchor: NSLayoutXAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        } else {
            return rightAnchor
        }
    }

    /// Returns safe area's top anchor
    var my_topAnchor: NSLayoutYAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    /// Returns safe area's bottom anchor
    var my_bottomAnchor: NSLayoutYAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    /// Returns safe area's center x anchor
    var my_centerXAnchor: NSLayoutXAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.centerXAnchor
        } else {
            return centerXAnchor
        }
    }

    /// Returns safe area's center y anchor
    var my_centerYAnchor: NSLayoutYAxisAnchor {

        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.centerYAnchor
        } else {
            return centerYAnchor
        }
    }
}
