// DetailTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Таблица детального обзора фильма
final class DetailTableViewController: UITableViewController {
    // MARK: - Public Properties

    var id: Int?

    // MARK: - Private Properties

    private var detailMovies: ParametrFilms?

    // MARK: - UITableViewController(DetailTableViewController)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        createRegister()
        fetchData()
    }

    private func createRegister() {
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
    }

    private func fetchData() {
        guard let idAnwrap = id else { return }
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/\(idAnwrap)?api_key=ab022f0a8f966780f47c834ccb3ac843&language=ru-RU"

        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.detailMovies = try decoder.decode(ParametrFilms.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("error json", error)
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailTableViewCell.identifier,
            for: indexPath
        ) as? DetailTableViewCell else { return UITableViewCell() }

        title = detailMovies?.title
        cell.configureCell(cell: detailMovies, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        700
    }
}
