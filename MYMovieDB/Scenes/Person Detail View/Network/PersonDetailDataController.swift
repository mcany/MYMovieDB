//
//  PersonDetailDataController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

struct PersonDetailDataController: PersonDetailDataProtocol {

    func fetchPersonDetail(personID: Int, completion: @escaping FetchPersonDetailCompletion) {

        let request = PersonDetailRequest(personID: personID)
        NetworkManager.shared.send(request: request) { result in
            let response = Person.model(withJSONData: result.data)
            completion(response, result.error)
        }
    }
}
