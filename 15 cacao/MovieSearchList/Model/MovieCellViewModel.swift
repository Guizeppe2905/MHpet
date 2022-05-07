//
//  MovieCellViewModel.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//

import Foundation

class MovieCellViewModel {
    let title: String?
    let image: URL?
    let description: String?
    init(
        title: String,
        image: URL?,
        description: String
    ) {
        self.title = title
        self.image = image
        self.description = description
    }
}
