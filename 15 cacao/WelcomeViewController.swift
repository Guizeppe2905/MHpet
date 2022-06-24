//
//  ViewController.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 21.02.2022.
//
// swiftlint: disable: function_body_length
// swiftlint: disable: identifier_name
import UIKit
import SnapKit
import AVFoundation
import SwiftUI

class WelcomeViewController: UIViewController {
    var animator: UIViewPropertyAnimator!
    var value: Int = -1
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 70, y: 700, width: 250, height: 50))
        button.setTitle("Старт", for: .normal)
        button.backgroundColor = Constants.Colors.primaryTeal
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let button1: UIButton = {
        let button1 = UIButton(frame: CGRect(x: 70, y: 700, width: 250, height: 50))
        button1.setTitle("Продолжить", for: .normal)
        button1.backgroundColor = Constants.Colors.primaryTeal
        button1.layer.cornerRadius = 10
        button1.setTitleColor(.white, for: .normal)
        return button1
    }()
    private let labelTitle: UILabel = {
       let label = UILabel()
       label.numberOfLines = 0
       label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
       label.textColor = Constants.Colors.primaryTeal
       label.text = "Добрый День!"
       label.alpha = 0.0
       return label
    }()
    private let labelO: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = Constants.Colors.primaryTeal
        label.text = "Д"
        label.alpha = 0.0
        return label
    }()
    private let labelO1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = Constants.Colors.primaryTeal
        label.text = "Д"
        label.alpha = 0.0
        return label
    }()
    private let labelD: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = Constants.Colors.primaryTeal
        label.text = "о"
        label.alpha = 0.0
        return label
    }()
    private let labelB: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = Constants.Colors.primaryTeal
        label.text = "е"
        label.alpha = 0.0
        return label
    }()
    private let girlImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Image.girl
       return imageView
    }()
    private let labelText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = ""
        return label
    }()
    private let typingString = "Спасибо, что решили посмотреть мой PET-проект!"
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .scaleAspectFit
        stackView.addSubview(labelTitle)
        stackView.addSubview(labelO)
        stackView.addSubview(labelO1)
        stackView.addSubview(labelD)
        stackView.addSubview(labelB)
        stackView.addSubview(girlImage)
        stackView.addSubview(labelText)
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setupConstraints()
        view.addSubview(button)
        change()
        button.addTarget(self,
                         action: #selector(typingText),
                         for: .touchUpInside)
    }
    @objc func didTapButton() {
        let tabBarVC = UITabBarController()
        let vc1 = UINavigationController(rootViewController: IntroductionViewController())
        let vc2 = UINavigationController(rootViewController: MoviesViewController())
        let vc3 =  UINavigationController(rootViewController: ListTableViewController())
        let vc4 = UINavigationController(rootViewController: AquariumViewController())
        let vc5 = UINavigationController(rootViewController: ApplicationViewController())
        vc1.title = "Обзор"
        vc2.title = "Фильмы"
        vc3.title = "Список сотрудников"
        vc4.title = "Аквариум"
        vc5.title = "Опросник"
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        guard let items = tabBarVC.tabBar.items else { return }
        let images = ["house", "star", "person", "bell", "lasso"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.barTintColor = .white
        tabBarVC.tabBar.unselectedItemTintColor = .white
        tabBarVC.tabBar.tintColor = .yellow
        tabBarVC.tabBar.backgroundColor = Constants.Colors.primaryTeal
        present(tabBarVC, animated: true)
    }
   @objc func change() {
        UIView.animate(withDuration: 1.5, delay: 0) { [weak self] in
            guard let self = self else { return }
            self.girlImage.alpha = 1.0
            self.labelO.alpha = 1.0
            self.labelO1.alpha = 1.0
            self.labelO.transform = CGAffineTransform(translationX: -14, y: 0)
            self.labelO1.transform = CGAffineTransform(translationX: 68, y: 0)
            }
           UIView.animate(withDuration: 5, delay: 2) { [weak self] in
               guard let self = self else { return }
               self.labelD.alpha = 1.0
               self.labelB.alpha = 1.0
               }
            UIView.animate(withDuration: 2, delay: 0.5) { [weak self] in
            guard let self = self else { return }
            self.labelTitle.alpha = 1.0
            self.labelO.alpha = 0.0
            self.labelO1.alpha = 0.0
            self.labelD.alpha = 0.0
            self.labelB.alpha = 0.0
            }
    }
    @objc private func typingText() {
        guard var text = labelText.text else { return }
        for char in typingString {
            AudioServicesPlaySystemSound(1306)
            text += "\(char)"
            labelText.text = text
            RunLoop.current.run(until: Date() + 0.1)
        }
        view.addSubview(button1)
        button1.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
    }
    private func setupConstraints() { stackView.snp.makeConstraints { make in
        make.height.equalTo(713)
        make.width.equalTo(375)
        make.leading.equalToSuperview().offset(0)
        make.trailing.equalToSuperview().offset(0)
        make.top.equalToSuperview().offset(0)
        make.bottom.equalToSuperview().offset(0)
    }
       labelTitle.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(260)
            make.leading.equalTo(stackView.snp.leading).offset(70)
            make.top.equalTo(stackView.snp.top).offset(100)
   }
        labelO.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(160)
            make.leading.equalTo(stackView.snp.leading).offset(92)
            make.top.equalTo(stackView.snp.top).offset(100)
    }
        labelO1.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(160)
            make.leading.equalTo(stackView.snp.leading).offset(160)
            make.top.equalTo(stackView.snp.top).offset(100)
    }
        labelD.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(160)
            make.leading.equalTo(stackView.snp.leading).offset(162)
            make.top.equalTo(stackView.snp.top).offset(100)
    }
        labelB.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(160)
            make.leading.equalTo(stackView.snp.leading).offset(212)
            make.top.equalTo(stackView.snp.top).offset(100)
    }
            labelText.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(160)
            make.leading.equalTo(stackView.snp.leading).offset(130)
            make.top.equalTo(stackView.snp.top).offset(270)
        }
            girlImage.snp.makeConstraints { make in
            make.height.equalTo(440)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(50)
            make.top.equalTo(stackView.snp.top).offset(250)
              }
}
}
