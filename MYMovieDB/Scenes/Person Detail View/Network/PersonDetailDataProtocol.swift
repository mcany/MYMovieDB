//
//  PersonDetailDataProtocol.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

typealias FetchPersonDetailCompletion = ((Person?, Error?) -> Void)

protocol PersonDetailDataProtocol {

    /// Fetches person detail of the given id
    /// - Parameters:
    ///   - personID: ID of the requested person
    ///   - completion: Completion block
    func fetchPersonDetail(personID: Int, completion: @escaping FetchPersonDetailCompletion)

}
