//
//  Date.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import Foundation

extension Date {

    func toString() -> String {
        let formatter = DateFormattingHelper.shared.dateFormatter
        return formatter.string(from: self)
    }
}
