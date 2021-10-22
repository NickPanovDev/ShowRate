// DetailTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Ячейка таблицы DetailTableViewController
final class DetailTableViewCell: UITableViewCell {
    // MARK: - Static Properties

    static let identifier = "DetailCell"

    // MARK: - Private Properties

    private let postImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let baseView = UIView()
    private let imageService = ImageService()

    // MARK: - UITableViewCell(DetailTableViewCell)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
    }

    // MARK: - Public Methods

    func configureCell(cell: DetailModel?, for indexPath: IndexPath) {
        guard let title = cell?.title,
              let posterPath = cell?.posterPath,
              let overview = cell?.overview else { return }

        titleLabel.text = title
        descriptionLabel.text = overview

        imageService.getImage(posterPath: posterPath) { [weak self] poster in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch poster {
                case let .success(image):
                    self.postImageView.image = image
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - private methods

    private func setupView() {
        createTitleLabel()
        createPosterImageView()
        createDescriptionLabel()
        createBaseView()

        createBaseViewConstraint()
        createPosterImageViewConstraint()
        createTitleLabelConstraint()
        createDescriptionLabelConstraint()
    }

    private func createBaseView() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 15
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.5
        baseView.layer.shadowOffset = .zero
        baseView.layer.shadowRadius = 4
        contentView.addSubview(baseView)
    }

    private func createBaseViewConstraint() {
        baseView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        baseView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        baseView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5)
            .isActive = true
        baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }

    private func createPosterImageView() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleToFill
        postImageView.layer.cornerRadius = 15
        postImageView.layer.borderWidth = 2
        postImageView.layer.borderColor = UIColor.systemPurple.cgColor
        baseView.addSubview(postImageView)
    }

    private func createPosterImageViewConstraint() {
        postImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
        postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor, multiplier: 1 / 1)
            .isActive = true
    }

    private func createTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        baseView.addSubview(titleLabel)
    }

    private func createTitleLabelConstraint() {
        titleLabel.topAnchor.constraint(equalTo: postImageView.topAnchor, constant: 380).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10)
            .isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10)
            .isActive = true
    }

    private func createDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 12
        baseView.addSubview(descriptionLabel)
    }

    private func createDescriptionLabelConstraint() {
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
    }
}
