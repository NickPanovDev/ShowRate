// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// MovieViewModelProtocol
protocol MovieViewModelProtocol {
    var films: [ParametrFilms]? { get set }
    var reloadData: (() -> ())? { get set }
    func getTopRated()
}

/// MovieViewModel
final class MovieViewModel: MovieViewModelProtocol {
    // MARK: - Public Properties

    var films: [ParametrFilms]?
    var reloadData: (() -> ())?

    // MARK: - Public Methods

    func getTopRated() {
        let jsonURL =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=ab022f0a8f966780f47c834ccb3ac843&language=ru-Ru&page=1"

        guard let url = URL(string: jsonURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let move = try decoder.decode(Films.self, from: data)
                self.films = move.results
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
