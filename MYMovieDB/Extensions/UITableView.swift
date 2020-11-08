//
//  UITableView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

extension UITableView {

    /// Registers cell with reuse id
    /// - Parameter : Meta type of the cell
    func my_register<T: UITableViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseID)
    }

    /// Dequeues cell assuming the cell is already registered.
    /// Check first whether the cell is registered or not.
    /// - Parameter indexPath: Index path of the cell
    /// - Returns: Dequeued cell
    func my_dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        if let cell =  dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T {
            return cell
        }
        fatalError("Failed to dequeue a cell with identifier \(T.reuseID) matching type \(T.self).")
    }
}
