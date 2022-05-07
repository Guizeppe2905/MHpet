//
//  Service.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//

import Foundation

class MoviesService: PresenterProtocol {
    static let shared = MoviesService()
    struct Constants {
        static let moviesURL = URL(string: "https://imdb-api.com/API/Search/k_sae3dg3h/star")
        static let searchUrlString = "https://imdb-api.com/API/Search/k_sae3dg3h/star"
    }
    init () {}
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://imdb-api.com/API/Search/k_sae3dg3h/star") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Movies: \(result.movies.count)")
                    completion(.success(result.movies))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    public func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Movies: \(result.movies.count)")
                    completion(.success(result.movies))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
