// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Таблица основного экрана с фильмами
final class MainTableViewController: UITableViewController {
    // MARK: - Public Properties

    var movieViewModel: MovieViewModelProtocol?
    var coordinator: MainCoordinator?
    var showDetails: IntHandler?

    // MARK: - UITableViewController(MainTableViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        title = "Топ рейтинг"
        createRegister()
        reloadData()
    }

    private func createRegister() {
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.identifier)
    }

    private func reloadData() {
        movieViewModel?.reloadData = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = movieViewModel?.films?.count else { return Int() }
        return section
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmsTableViewCell.identifier,
            for: indexPath
        ) as? FilmsTableViewCell else { return UITableViewCell() }

        cell.configureCell(cell: movieViewModel?.films, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailID = movieViewModel?.films?[indexPath.row].id else { return }
        showDetails?(detailID)
    }
}
