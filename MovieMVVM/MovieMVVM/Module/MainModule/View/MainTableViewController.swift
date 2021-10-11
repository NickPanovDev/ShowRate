// MainTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Таблица основного экрана с фильмами
final class MainTableViewController: UITableViewController {
    // MARK: - Private Properties

    private var movies: Films?

    // MARK: - UITableViewController(MainTableViewController)

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
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.identifier)
    }

    private func fetchData() {
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=ab022f0a8f966780f47c834ccb3ac843&language=ru-Ru&page=1"

        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.movies = try decoder.decode(Films.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("error json", error)
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = movies?.results.count else { return Int() }
        return section
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmsTableViewCell.identifier,
            for: indexPath
        ) as? FilmsTableViewCell else { return UITableViewCell() }

        cell.configureCell(cell: movies, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailTableViewController()
        guard let detail = movies?.results[indexPath.row].id else { return }
        detailVC.id = detail
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
