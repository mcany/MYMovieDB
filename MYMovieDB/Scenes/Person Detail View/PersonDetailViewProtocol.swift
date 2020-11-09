//
//  PersonDetailViewProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

protocol PersonDetailViewProtocol {

    /// State change handler to handle changes
    var stateChangeHandler: PersonDetailViewStateOnChange? { get set }

    /// Fetches person detail
    func fetchPersonDetail()

}
