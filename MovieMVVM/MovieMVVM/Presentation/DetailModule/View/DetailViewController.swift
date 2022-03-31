// DetailViewController.swift
// Copyright © ShowRate. All rights reserved.

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Public Properties

    var detailViewModel: DetailViewModelProtocol?

    // MARK: - Private Properties

    private var collectionView: UICollectionView?

    // MARK: - UIViewController(DetailViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView?.backgroundColor = .systemGray6

        view.addSubview(collectionView ?? UICollectionView())

        collectionView?.dataSource = self
        registerCell()
        reloadData()
    }

    private func reloadData() {
        detailViewModel?.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView?.reloadData()
        }
    }

    private func registerCell() {
        collectionView?.register(
            DetailCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailCollectionViewCell.identifier
        )
    }

    private func detailtopRatingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
            .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 16

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:
            .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(1000)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 0)

        return section
    }

    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ in
            self?.detailtopRatingSection()
        }
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailCollectionViewCell.identifier,
            for: indexPath
        ) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(cell: detailViewModel?.films, for: indexPath)
        return cell
    }
}
