//
//  ListViewTableViewCell.swift
//  MYMovieDB
//
//  Created by Mertcan Yigin on 8.11.2020.
//

import UIKit

final class ListViewTableViewCell: UITableViewCell {

    private enum Constant {

        static let inset: CGFloat = 5
        static let padding = UIEdgeInsets(top: Layout.margin,
                                          left: Layout.margin,
                                          bottom: -Layout.margin,
                                          right: -Layout.margin)

        enum Tumbnail {
            static let size = CGSize(width: 100, height: 150)
            static let cornerRadius: CGFloat = 6
        }
    }

    private let thumbnailImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: Constant.Tumbnail.size.width)
            .isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constant.Tumbnail.size.height)
            .isActive = true
        imageView.layer.cornerRadius = Constant.Tumbnail.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.imageWidth = Constant.Tumbnail.size.width
        return imageView
    }()

    private let detailHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = Theme.label
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "chevronRight")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle = .default,
                  reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Configuration

extension ListViewTableViewCell {

    func configure(imagePath: String?) {
        thumbnailImageView.imagePath = imagePath
    }

    func configure(title: String?) {
        titleLabel.text = title
    }

    func configure(genre: String?) {
        genreLabel.text = genre
    }

    func configure(date: String?) {
        dateLabel.text = date
    }
}

// MARK: Private Configuration

private extension ListViewTableViewCell {

    func prepareViews() {

        var constraints: [NSLayoutConstraint] = []

        contentView.addSubview(thumbnailImageView)
        contentView.dock(view: thumbnailImageView,
                         constants: Constant.padding,
                         excludingEdge: .right)

        contentView.addSubview(detailHolderView)
        contentView.dock(view: detailHolderView,
                         constants: Constant.padding,
                         excludingEdge: [.left, .right])

        constraints.append(
            detailHolderView.my_leadingAnchor.constraint(equalTo: thumbnailImageView.my_trailingAnchor,
                                                         constant: Layout.margin))

        contentView.addSubview(chevronImageView)
        constraints.append(contentsOf: [
            contentView.my_trailingAnchor.constraint(equalTo:
                                                        chevronImageView.my_trailingAnchor,
                                                     constant: Layout.margin),
            chevronImageView.my_centerYAnchor.constraint(equalTo: contentView.my_centerYAnchor),
            chevronImageView.my_leadingAnchor.constraint(greaterThanOrEqualTo: detailHolderView.my_trailingAnchor,
                                                         constant: Layout.margin)
        ])

        detailHolderView.addSubview(titleLabel)
        detailHolderView.addSubview(genreLabel)
        detailHolderView.addSubview(dateLabel)
        constraints.append(contentsOf: [
            titleLabel.my_topAnchor.constraint(equalTo: detailHolderView.my_topAnchor,
                                               constant: Constant.inset),
            titleLabel.my_leadingAnchor.constraint(equalTo: detailHolderView.my_leadingAnchor,
                                                   constant: Constant.inset),
            titleLabel.my_trailingAnchor.constraint(equalTo: detailHolderView.my_trailingAnchor,
                                                    constant: -Constant.inset),
            titleLabel.my_bottomAnchor.constraint(equalTo: genreLabel.my_topAnchor,
                                                  constant: -Constant.inset),
            genreLabel.my_leadingAnchor.constraint(equalTo: detailHolderView.my_leadingAnchor,
                                                   constant: Constant.inset),
            genreLabel.my_trailingAnchor.constraint(equalTo: detailHolderView.my_trailingAnchor,
                                                    constant: -Constant.inset),
            genreLabel.my_bottomAnchor.constraint(equalTo: dateLabel.my_topAnchor,
                                                  constant: -Constant.inset),
            dateLabel.my_leadingAnchor.constraint(equalTo: detailHolderView.my_leadingAnchor,
                                                  constant: Constant.inset),
            dateLabel.my_trailingAnchor.constraint(equalTo: detailHolderView.my_trailingAnchor,
                                                   constant: -Constant.inset),
            dateLabel.my_bottomAnchor.constraint(lessThanOrEqualTo: detailHolderView.my_bottomAnchor,
                                                 constant: -Constant.inset)

        ])
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: Private Reusable

extension ListViewTableViewCell: Reusable { }
