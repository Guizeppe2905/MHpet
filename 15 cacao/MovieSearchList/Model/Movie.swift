//
//  Movie.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//

import Foundation

struct APIResponse: Decodable {
    let movies: [Movie]
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
struct Movie: Decodable {
    let title: String?
    let image: String?
    let description: String?
}
