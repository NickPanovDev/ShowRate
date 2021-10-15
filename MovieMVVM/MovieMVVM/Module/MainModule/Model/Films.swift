// Films.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Параметры
final class Films: Object, Decodable {
    /// Номер страницы
    @objc dynamic var page: Int
    /// Список фильмов и их параметры
    var results: [ParametrFilms] = []
}
