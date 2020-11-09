//
//  UICollectionView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

import UIKit

extension UICollectionView {

    func my_register<T: UICollectionViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseID)
    }

    func my_dequeueReusableCell<T: Reusable>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as! T
    }
}
