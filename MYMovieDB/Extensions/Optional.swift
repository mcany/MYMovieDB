//
//  Optional.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

extension Optional where Wrapped == String {

    var isNilOrEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

extension Optional where Wrapped: Collection {

    var isNilOrEmpty: Bool {
        switch self {
        case .some(let collection):
            return collection.isEmpty
        case .none:
            return true
        }
    }
}
