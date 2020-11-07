//
//  UIView+Layout.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

extension UIView {

    /// Adds top, leading, trailing, bottom constraints with given constants
    /// Also activates the constraints right away
    ///
    /// - Parameters:
    ///   - view: View that constraints will be added
    ///   - constants: Constraint constants that will be applied for respective directions
    ///   - excludedEdge: Edge set that contains edges are excluded from being docked
    ///   - safeAreaEdge: Edge set that contains edges are constrained to safe area's anchors
    func dock(view: UIView,
              constants: UIEdgeInsets = .zero,
              excludingEdge excludedEdge: UIRectEdge = [],
              safeAreaEdge: UIRectEdge = []) {

        if !excludedEdge.contains(.bottom) {

            view.bottomAnchor.constraint(equalTo: safeAreaEdge.contains(.bottom) ? my_bottomAnchor : bottomAnchor,
                                         constant: constants.bottom).isActive = true
        }

        if !excludedEdge.contains(.top) {

            view.topAnchor.constraint(equalTo: safeAreaEdge.contains(.top) ? my_topAnchor : topAnchor,
                                      constant: constants.top).isActive = true
        }

        if !excludedEdge.contains(.left) {

            view.leadingAnchor.constraint(equalTo: safeAreaEdge.contains(.left) ? my_leadingAnchor : leadingAnchor,
                                          constant: constants.left).isActive = true
        }

        if !excludedEdge.contains(.right) {

            view.trailingAnchor.constraint(equalTo: safeAreaEdge.contains(.right) ? my_trailingAnchor : trailingAnchor,
                                           constant: constants.right).isActive = true
        }
    }
}
