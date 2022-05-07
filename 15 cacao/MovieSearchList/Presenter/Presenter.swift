//
//  Presenter.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//

import Foundation

protocol PresenterProtocol {
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}
class Presenter: NSObject {
    private var movieService: PresenterProtocol
    var reloadTableView: (() -> Void)?
    var movieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init(movieService: PresenterProtocol = MoviesService()) {
        self.movieService = movieService
    }
    func getMovies() {
        movieService.getMovies { [weak self] result in
            switch result {
            case .success(let movies):
               self?.movieCellViewModels = movies.compactMap({
                   MovieCellViewModel(
                    title: $0.title!,
                    image: URL(string: $0.image ?? ""),
                    description: $0.description ?? "No Description"
                    )
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return movieCellViewModels[indexPath.row]
    }
}
