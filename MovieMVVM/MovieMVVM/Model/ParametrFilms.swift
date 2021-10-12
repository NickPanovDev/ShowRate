// ParametrFilms.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о фильмах
struct ParametrFilms: Decodable {
    /// ID фильма
    let id: Int?
    /// Название фильма
    let title: String?
    /// Описание фильма
    let overview: String?
    /// Рейтинг фильма
    let voteAverage: Float?
    /// Постер фильма
    let posterPath: String?
    /// Дата выхода
    let releaseDate: String?
}
