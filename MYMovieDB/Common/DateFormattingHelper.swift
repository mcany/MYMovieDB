//
//  DateFormattingHelper.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import Foundation

class DateFormattingHelper {

    // MARK: - Shared

    static let shared = DateFormattingHelper()

    // MARK: - Formatters

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter
    }()
}
