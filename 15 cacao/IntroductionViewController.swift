//
//  IntroductionViewController.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 06.05.2022.
//
// swiftlint: disable: line_length
import UIKit

class IntroductionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collection: UICollectionView!
   var items = ["movieImage", "employeesImage", "fishImage", "applicationImage"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.primaryTeal
        UINavigationBar.appearance().prefersLargeTitles = true
        setUpUI()
    }
    private func setUpUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = Constants.Colors.primaryTeal
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 10)
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: 400).isActive = true
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Слайд-обзор"
        title.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        title.textColor = .white
        let description = UILabel()
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text =
        "Экран№1 - Обзор - NSLayoutConstraint, UICollectionViewCells \nЭкран№2 - Список фильмов - MVP, REST API \nЭкран№3 - Список сотрудников - CoreData, SnapKit \nЭкран№4 - Аквариум - Анимация \nЭкран№5 - Опросник - URLSession, Alamofire, SnapKit"
        description.font = Constants.Fonts.kRegular
        description.textColor = .white
        let stackView = UIStackView(arrangedSubviews: [title, description])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: UIImage(named: items[indexPath.row]))
        cell.addSubview(imageView)
        cell.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.75, height: 400)
    }
}
