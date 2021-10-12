// Film.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Параметры
struct Films: Decodable {
    /// Номер страницы
    let page: Int
    /// Список фильмов и их параметры
    let results: [ParametrFilms]
}
