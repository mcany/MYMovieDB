//
//  ListViewController.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 7.11.2020.
//

import UIKit

final class ListViewController: UIViewController {

    private let viewModel: ListViewProtocol

    init(with viewModel: ListViewProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var helloWorldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()
        viewModel.fetchMovies()
    }

    private func prepareViews() {

        title = "My list"
        view.backgroundColor = .white
        view.addSubview(helloWorldLabel)
        NSLayoutConstraint.activate([
            helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        helloWorldLabel.text = "Hello World"
    }
}
