//
//  FirstVC.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 28.04.2022.
//
// swiftlint: disable: colon
// swiftlint: disable: line_length
import UIKit
import SnapKit

class MoviesViewController: UIViewController, UISearchBarDelegate, PresenterProtocol {
    private let tableView: UITableView = {
        let table = UITableView()
       table.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        table.backgroundColor = Constants.Colors.primaryTeal
        return table
    }()
    lazy var presenter = {
        Presenter()
    }()
    private let searchVC = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        initViewModel()
        createSearchBar()
        view.backgroundColor = Constants.Colors.primaryTeal
        setNavBar()
    }
    private func setNavBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.backgroundColor = Constants.Colors.primaryTeal
        navigationController?.navigationBar.topItem!.title = "Фильмы"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)]
    }
    func initViewModel() {
        presenter.getMovies()
        presenter.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.searchTextField.backgroundColor = .white
    }
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
private func setupConstraints() {
    tableView.snp.makeConstraints { make in
    make.leading.equalToSuperview()
    make.trailing.equalToSuperview()
    make.top.equalToSuperview().offset(10)
    make.bottom.equalToSuperview()
    }
}
}
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCell",
            for: indexPath)
                as? MovieCell else { fatalError("error") }
        let cellVM = presenter.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
            MoviesService.shared.search(with: text) { [weak self] result in
                   switch result {
                   case .success(let movies):
                       self?.presenter.movieCellViewModels = movies.compactMap({
                           MovieCellViewModel(
                               title: $0.title!,
                               image: URL(string: $0.image ?? ""),
                               description: $0.description ?? "No Description"
                       )
                       })
                       DispatchQueue.main.async {
                           self?.tableView.reloadData()
                           self?.searchVC.dismiss(animated: true, completion: nil)
                       }
                   case .failure(let error):
                       print(error)
                   }
               }
    }
}
