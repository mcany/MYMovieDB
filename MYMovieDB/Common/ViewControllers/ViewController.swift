//
//  ViewController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties

    private var statusView: StatusView?
    private var loadingView: LoadingView?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.background
        applyNaivgationBarStyling()
    }
}

// MARK: Loading View

extension ViewController {

    /// Shows loading view
    func showLoadingView() {

        removeLoadingView()

        view.endEditing(true)
        loadingView = LoadingView()
        guard let loadingView = loadingView else {
            return
        }
        view.addSubview(loadingView)
        view.dock(view: loadingView)
        loadingView.startAnimating()
    }

    /// Removes loading view if added
    func removeLoadingView() {
        loadingView?.stopAnimating()
        loadingView?.removeFromSuperview()
    }
}

// MARK: Status View

extension ViewController {

    /// Shows status view with given parameters
    /// - Parameters:
    ///   - iconName: Icon name
    ///   - message: Message text
    func showStatusView(iconName: String, message: String) {

        removeStatusView()
        statusView = StatusView()

        view.endEditing(true)
        guard let statusView = statusView else {
            return
        }

        statusView.configure(with: iconName, message: message)
        view.addSubview(statusView)
        view.dock(view: statusView)
    }

    /// Removes status view if added
    func removeStatusView() {
        statusView?.removeFromSuperview()
    }
}

// MARK: Styling

private extension ViewController {

    func applyNaivgationBarStyling() {
        navigationController?.navigationBar.applyStyling()
    }
}
