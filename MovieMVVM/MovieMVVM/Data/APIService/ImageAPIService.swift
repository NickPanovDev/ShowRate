// ImageAPIService.swift
// Copyright © ShowRate. All rights reserved.

import Foundation
import UIKit

/// ImageAPIServiceProtocol
protocol ImageAPIServiceProtocol: AnyObject {
    func getImage(posterPath: String, completion: @escaping (Swift.Result<Data, Error>) -> ())
}

/// ImageAPIService
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Private Properties

    private let imageURL = "https://image.tmdb.org/t/p/w500"

    // MARK: - Public Methods

    func getImage(posterPath: String, completion: @escaping (Swift.Result<Data, Error>) -> ()) {
        DispatchQueue.global().async {
            do {
                guard let url = URL(string: self.imageURL + posterPath) else { return }
                let imageData = try Data(contentsOf: url)
                completion(.success(imageData))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
