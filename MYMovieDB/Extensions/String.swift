//
//  String.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import Foundation

extension String {

    func toDate(using format: String?) -> Date? {
        let formatter = DateFormattingHelper.shared.dateFormatter
        if let format = format {
            formatter.dateFormat = format
        }
        return formatter.date(from: self)
    }
}
