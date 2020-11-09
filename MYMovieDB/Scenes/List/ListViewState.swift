//
//  ListViewState.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

typealias ListViewStateOnChange = ((ListViewState.Change) -> Void)

final class ListViewState {

    /// State changes
    enum Change {
        case loading(Bool)
        case listItems([ListViewData]?)
        case selectedItemID(MediaType?, Int)
        case viewType
    }

    enum ViewType {
        case list
        case search
    }

    /// On change listener function
    var onChange: ListViewStateOnChange?

    /// Loading state of the view
    var loading = false {
        didSet {
            onChange?(.loading(loading))
        }
    }

    /// List items of the view
    var listItems: [ListViewData]? {
        didSet {
            onChange?(.listItems(listItems))
        }
    }

    /// Selected list item of the view
    var selectedItem: ListViewData? {
        didSet {
            guard let selectedItem = selectedItem else {
                return
            }
            onChange?(.selectedItemID(selectedItem.mediaType,
                                      selectedItem.identifier))
        }
    }

    /// Current view type
    var viewType: ViewType = .list {
        didSet {
            onChange?(.viewType)
        }
    }
}
