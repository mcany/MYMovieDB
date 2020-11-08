//
//  ImageView.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class ImageView: UIImageView {

    private enum ActivityIndicatorView {

        static let width: CGFloat = 100
        static let height: CGFloat = 100
    }

    private lazy var imageLoader = ImageLoader()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.applyStyling()
        return indicator
    }()

    var imagePath: String? {
        didSet {
            guard let path = imagePath else {
                return
            }
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            imageLoader.loadImage(path: path) { [weak self] image in
                self?.activityIndicatorView.stopAnimating()
                self?.activityIndicatorView.isHidden = true
                self?.image = image
            }
        }
    }

    var imageWidth: CGFloat? {
        didSet {
            guard let imageWidth = imageWidth else { return }
            imageLoader.imageWidth = Int(imageWidth)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.widthAnchor.constraint(equalToConstant: ActivityIndicatorView.width),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: ActivityIndicatorView.height),
            activityIndicatorView.my_centerXAnchor.constraint(equalTo: my_centerXAnchor),
            activityIndicatorView.my_centerYAnchor.constraint(equalTo: my_centerYAnchor)
        ])
    }
}
