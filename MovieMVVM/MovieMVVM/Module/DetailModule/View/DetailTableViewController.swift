// DetailTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Таблица детального обзора фильма
final class DetailTableViewController: UITableViewController {

    // MARK: - Private Properties

    private var detailViewModel: DetailViewModelProtocol?

    // MARK: - Initializers

    init(view: DetailViewModelProtocol) {
        detailViewModel = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewController(DetailTableViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        createRegister()
        reloadData()
    }

    private func createRegister() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
    }

    private func reloadData() {
        detailViewModel?.reloadData = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.identifier,
            for: indexPath
        ) as? DetailTableViewCell else { return UITableViewCell() }

        cell.configureCell(cell: detailViewModel?.films, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        700
    }
}
