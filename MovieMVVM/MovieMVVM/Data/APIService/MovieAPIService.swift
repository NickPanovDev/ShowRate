// MovieAPIService.swift
// Copyright © Movie. All rights reserved.

import Foundation
import RealmSwift

protocol MovieAPIServiceProtocol {
    func getRated(complition: @escaping (Swift.Result<[ParametrFilms], Error>) -> Void)
    func getDetailRated(id: Int?, complition: @escaping (Swift.Result<DetailModel, Error>) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Public Methods

    func getRated(complition: @escaping (Swift.Result<[ParametrFilms], Error>) -> Void) {
        let jsonURL =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=ab022f0a8f966780f47c834ccb3ac843&language=ru-Ru&page=1"

        guard let url = URL(string: jsonURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let move = try decoder.decode(Films.self, from: data)
                complition(.success(move.results))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }

    func getDetailRated(id: Int?, complition: @escaping (Swift.Result<DetailModel, Error>) -> Void) {
        guard let idAnwrap = id else { return }
        let jsonURL =
            "https://api.themoviedb.org/3/movie/\(idAnwrap)?api_key=ab022f0a8f966780f47c834ccb3ac843&language=ru-RU"

        guard let url = URL(string: jsonURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let detailMovies = try decoder.decode(DetailModel.self, from: data)
                complition(.success(detailMovies))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
