// MainViewController.swift
// Copyright © ShowRate. All rights reserved.

import UIKit

///
final class MainViewController: UIViewController {
    // MARK: - Enum

    enum Constans {
        static let title = "Топ рейтинг"
        static let accessibilityIdentifier = "MainViewController"
    }

    // MARK: - Public Properties

    var movieViewModel: MovieViewModelProtocol?
    var showDetails: IntHandler?

    // MARK: - Private Properties

    private var collectionView: UICollectionView?

    // MARK: - UIViewController(MainViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView?.backgroundColor = .systemGray6

        title = Constans.title
        collectionView?.accessibilityIdentifier = Constans.accessibilityIdentifier
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.dataSource = self
        collectionView?.delegate = self
        registerCell()
        reloadData()
    }

    private func reloadData() {
        movieViewModel?.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView?.reloadData()
        }
    }

    private func registerCell() {
        collectionView?.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
    }

    private func topRatingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
            .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(350)
            )
        )

        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 16

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:
            .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 0)

        return section
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.topRatingSection()
        }
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = movieViewModel?.films?.count else { return Int() }
        return section
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.identifier,
            for: indexPath
        ) as? MainCollectionViewCell else { return UICollectionViewCell() }

        cell.configureCell(cell: movieViewModel?.films, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailID = movieViewModel?.films?[indexPath.row].id else { return }
        showDetails?(detailID)
    }
}
