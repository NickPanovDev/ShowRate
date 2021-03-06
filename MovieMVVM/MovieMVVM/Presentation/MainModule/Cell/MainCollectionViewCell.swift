// MainCollectionViewCell.swift
// Copyright © ShowRate. All rights reserved.

import RealmSwift
import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    // MARK: - Static Properties

    static let identifier = "FilmsCell"

    // MARK: - Private Properties

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let baseView = UIView()
    private let imageService = ImageService()

    // MARK: - UICollectionViewCell(MainCollectionViewCell)

    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        setupView()
    }

    // MARK: - Public Methods

    func configureCell(cell: Results<ParametrFilms>?, for indexPath: IndexPath) {
        guard let title = cell?[indexPath.row].title,
              let posterPath = cell?[indexPath.row].posterPath else { return }

        titleLabel.text = title

        imageService.getImage(posterPath: posterPath) { [weak self] poster in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch poster {
                case let .success(image):
                    self.posterImageView.image = image
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setupView() {
        createTitleLabel()
        createPosterImageView()
        createBaseView()

        createBaseViewConstraint()
        createPosterImageViewConstraint()
        createTitleLabelConstraint()
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
        baseView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        baseView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -0)
            .isActive = true
        baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
    }

    private func createPosterImageView() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 15
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.systemPurple.cgColor
        baseView.addSubview(posterImageView)
    }

    private func createPosterImageViewConstraint() {
        posterImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -50)
            .isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 5).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -5).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 1 / 1.4)
            .isActive = true
    }

    private func createTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        baseView.addSubview(titleLabel)
    }

    private func createTitleLabelConstraint() {
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -5).isActive = true
    }
}
