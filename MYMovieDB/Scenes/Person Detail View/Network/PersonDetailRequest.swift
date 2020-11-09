//
//  PersonDetailRequest.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct PersonDetailRequest: Request {

    private enum Parameter {

        static let personID = "person_id"
        static let baseEndpoint = "person"
    }

    let endpoint: String

    let method: HTTPMethod = .get

    /// Inits request with given person ID parameter
    /// - Parameter personID: Person ID
    init(personID: Int) {

        self.endpoint = "\(Parameter.baseEndpoint)/\(personID)"
    }
}
