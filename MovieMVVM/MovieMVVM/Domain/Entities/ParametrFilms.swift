// ParametrFilms.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Информация о фильмах
final class ParametrFilms: Object, Decodable {
    /// ID фильма
    @objc dynamic var id: Int
    /// Название фильма
    @objc dynamic var title: String
    /// Описание фильма
    @objc dynamic var overview: String
    /// Рейтинг фильма
    @objc dynamic var voteAverage: Float
    /// Постер фильма
    @objc dynamic var posterPath: String
    /// Дата выхода
    @objc dynamic var releaseDate: String

    override static func primaryKey() -> String? {
        "id"
    }
}
