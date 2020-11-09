//
//  PersonDetailViewModel.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 9.11.2020.
//

final class PersonDetailViewModel {

    // MARK: Properties

    private let personID: Int

    private let dataController: PersonDetailDataProtocol

    private let state = PersonDetailViewState()

    // MARK: Lifecycle

    init(with personID: Int, dataController: PersonDetailDataProtocol ) {
        self.personID = personID
        self.dataController = dataController
    }
}

extension PersonDetailViewModel: PersonDetailViewProtocol {

    var stateChangeHandler: PersonDetailViewStateOnChange? {
        get { return state.onChange }
        set { state.onChange = newValue }
    }
}

// MARK: Data Functions

extension PersonDetailViewModel {

    func fetchPersonDetail() {

        state.loading = true
        dataController.fetchPersonDetail(personID: personID) { [weak self] (reponse, _) in

            self?.state.loading = false
            self?.state.person = reponse
        }
    }
}
