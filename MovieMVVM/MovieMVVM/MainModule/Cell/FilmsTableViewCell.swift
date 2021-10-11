// FilmsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка таблицы MainViewController
final class FilmsTableViewCell: UITableViewCell {
    static let identifier = "FilmsCell"

    // MARK: - private properties

    private let posterImageView = UIImageView()
    private let titleLable = UILabel()
    private let descriptionLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let gradeFilms = UILabel()
    private let baseView = UIView()

    // MARK: - UITableViewCell(FilmsTableViewCell)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
    }

    // MARK: - Public methods

    func configureCell(cell: Films?, for indexPath: IndexPath) {
        guard let title = cell?.results[indexPath.row].title,
              let posterPath = cell?.results[indexPath.row].posterPath,
              let overview = cell?.results[indexPath.row].overview,
              let releaseDate = cell?.results[indexPath.row].releaseDate,
              let voteAverage = cell?.results[indexPath.row].voteAverage else { return }

        titleLable.text = title
        descriptionLabel.text = overview
        releaseDateLabel.text = releaseDate
        gradeFilms.text = String(voteAverage)

        DispatchQueue.global().async {
            let constImage = "https://image.tmdb.org/t/p/w500/"
            guard let urlImage = URL(string: "\(constImage)\(posterPath)"),
                  let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
    }

    // MARK: - private methods

    private func setupView() {
        createTitleLable()
        createPosterImageView()
        createDescriptionLabel()
        createReleaseDateLabel()
        createGradeFilms()
        createBaseView()

        createBaseViewConstraint()
        createPosterImageViewConstraint()
        createTitleLableConstraint()
        createDescriptionLabelConstraint()
        createGradeFilmsConstraint()
        createReleaseDateLabelConstraint()
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
        posterImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5)
            .isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 5).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 1 / 1.4)
            .isActive = true
    }

    private func createTitleLable() {
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.font = UIFont.boldSystemFont(ofSize: 16)
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 2
        baseView.addSubview(titleLable)
    }

    private func createTitleLableConstraint() {
        titleLable.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
    }

    private func createDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 5
        baseView.addSubview(descriptionLabel)
    }

    private func createDescriptionLabelConstraint() {
        descriptionLabel.topAnchor.constraint(equalTo: titleLable.topAnchor, constant: 40).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
    }

    private func createGradeFilms() {
        gradeFilms.translatesAutoresizingMaskIntoConstraints = false
        gradeFilms.font = UIFont.boldSystemFont(ofSize: 16)
        gradeFilms.textColor = .systemPurple
        baseView.addSubview(gradeFilms)
    }

    private func createGradeFilmsConstraint() {
        gradeFilms.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -10).isActive = true
        gradeFilms.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
    }

    private func createReleaseDateLabel() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(releaseDateLabel)
    }

    private func createReleaseDateLabelConstraint() {
        releaseDateLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -10).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10).isActive = true
    }
}
