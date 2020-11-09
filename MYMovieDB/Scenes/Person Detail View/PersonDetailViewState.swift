//
//  PersonDetailViewState.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

typealias PersonDetailViewStateOnChange = ((PersonDetailViewState.Change) -> Void)

final class PersonDetailViewState {

    /// State changes
    enum Change {
        case loading(Bool)
        case person(Person)
    }

    /// On change listener function
    var onChange: PersonDetailViewStateOnChange?

    /// Loading state of the view
    var loading = false {
        didSet {
            onChange?(.loading(loading))
        }
    }

    /// Person data of the view
    var person: Person? {
        didSet {
            guard let person = person else {
                return
            }
            onChange?(.person(person))
        }
    }
}
