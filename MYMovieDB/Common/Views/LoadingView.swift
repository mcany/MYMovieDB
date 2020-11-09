//
//  LoadingView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class LoadingView: UIView {

    private enum ActivityIndicatorView {

        static let width: CGFloat = 100.0
        static let height: CGFloat = 100.0
    }

    // MARK: Properties

    private var activityIndicatorView: UIActivityIndicatorView?

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Actions

extension LoadingView {

    func startAnimating() {
        activityIndicatorView?.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    func stopAnimating() {
        activityIndicatorView?.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

// MARK: Private Configuration

private extension LoadingView {

    func prepareViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView?.applyStyling()
        guard let activityIndicatorView = activityIndicatorView  else {
            return
        }
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.widthAnchor.constraint(equalToConstant: ActivityIndicatorView.width),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: ActivityIndicatorView.height),
            activityIndicatorView.my_centerXAnchor.constraint(equalTo: my_centerXAnchor),
            activityIndicatorView.my_centerYAnchor.constraint(equalTo: my_centerYAnchor)
        ])
    }
}
