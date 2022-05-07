//
//  ThirdVC.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//
// swiftlint: disable: type_body_length
// swiftlint: disable: colon
// swiftlint: disable: function_body_length
import UIKit
import SnapKit
import Alamofire

class ApplicationViewController: UIViewController, UITextFieldDelegate {
    var yearInt: Int = 0
    var occupationString: String = ""
    var nameString: String = ""
    var lastnameString: String = ""
    var countryString: String = ""
    private let labelYear: UILabel = {
        let labelYear = UILabel()
        labelYear.numberOfLines = 0
        labelYear.font = .systemFont(ofSize: 14, weight: .semibold)
        labelYear.text = "Год рождения (цифры)"
        return labelYear
    }()
    private let labelOccupation: UILabel = {
        let labelOcupation = UILabel()
        labelOcupation.numberOfLines = 0
        labelOcupation.font = .systemFont(ofSize: 14, weight: .semibold)
        labelOcupation.text = "Профессия"
        return labelOcupation
    }()
    private let labelName: UILabel = {
        let labelName = UILabel()
        labelName.numberOfLines = 0
        labelName.font = .systemFont(ofSize: 14, weight: .semibold)
        labelName.text = "Имя"
        return labelName
    }()
    private let labelLastName: UILabel = {
        let labelLastName = UILabel()
        labelLastName.numberOfLines = 0
        labelLastName.font = .systemFont(ofSize: 14, weight: .semibold)
        labelLastName.text = "Фамилия"
        return labelLastName
    }()
    private let labelCountry: UILabel = {
        let labelCountry = UILabel()
        labelCountry.numberOfLines = 0
        labelCountry.font = .systemFont(ofSize: 14, weight: .semibold)
        labelCountry.text = "Страна"
        return labelCountry
    }()
    private let yearTextField: UITextField = {
    let yearTextField =  UITextField()
        yearTextField.placeholder = "Введите Ваш год рождения"
        yearTextField.font = UIFont.systemFont(ofSize: 14)
        yearTextField.borderStyle = UITextField.BorderStyle.roundedRect
        yearTextField.autocorrectionType = UITextAutocorrectionType.no
        yearTextField.keyboardType = .numberPad
        yearTextField.returnKeyType = UIReturnKeyType.done
        yearTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        yearTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return yearTextField
    }()
    private let occupationTextField: UITextField = {
    let occupationTextField =  UITextField()
        occupationTextField.placeholder = "Введите Вашу профессию"
        occupationTextField.font = UIFont.systemFont(ofSize: 14)
        occupationTextField.borderStyle = UITextField.BorderStyle.roundedRect
        occupationTextField.autocorrectionType = UITextAutocorrectionType.no
        occupationTextField.keyboardType = UIKeyboardType.default
        occupationTextField.returnKeyType = UIReturnKeyType.done
        occupationTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        occupationTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return occupationTextField
    }()
    private let nameTextField: UITextField = {
    let nameTextField =  UITextField()
        nameTextField.placeholder = "Введите Ваше имя"
        nameTextField.font = UIFont.systemFont(ofSize: 14)
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return nameTextField
    }()
    private let lastNameTextField: UITextField = {
    let lastNameTextField =  UITextField()
        lastNameTextField.placeholder = "Введите Вашу фамилию"
        lastNameTextField.font = UIFont.systemFont(ofSize: 14)
        lastNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        lastNameTextField.autocorrectionType = UITextAutocorrectionType.no
        lastNameTextField.keyboardType = UIKeyboardType.default
        lastNameTextField.returnKeyType = UIReturnKeyType.done
        lastNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        lastNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return lastNameTextField
    }()
    private let countryTextField: UITextField = {
    let countryTextField =  UITextField()
        countryTextField.placeholder = "Введите Вашу страну"
        countryTextField.font = UIFont.systemFont(ofSize: 14)
        countryTextField.borderStyle = UITextField.BorderStyle.roundedRect
        countryTextField.autocorrectionType = UITextAutocorrectionType.no
        countryTextField.keyboardType = UIKeyboardType.default
        countryTextField.returnKeyType = UIReturnKeyType.done
        countryTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        countryTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return countryTextField
    }()
    private let urlSessionButton: UIButton = {
        let urlSessionButton = UIButton()
        urlSessionButton.subtitleLabel?.numberOfLines = 0
        urlSessionButton.setTitle("URLSession", for: .normal)
        urlSessionButton.backgroundColor = Constants.Colors.primaryTeal
        urlSessionButton.setTitleColor(.white, for: .normal)
        urlSessionButton.layer.cornerRadius = 9
        urlSessionButton.layer.borderWidth = 1
        urlSessionButton.layer.borderColor = UIColor.gray.cgColor
        return urlSessionButton
    }()
    private let alamofireButton: UIButton = {
        let alamofireButton = UIButton()
        alamofireButton.subtitleLabel?.numberOfLines = 0
        alamofireButton.setTitle("Alamofire", for: .normal)
        alamofireButton.backgroundColor = Constants.Colors.primaryTeal
        alamofireButton.setTitleColor(.white, for: .normal)
        alamofireButton.layer.cornerRadius = 9
        alamofireButton.layer.borderWidth = 1
        alamofireButton.layer.borderColor = UIColor.gray.cgColor
        return alamofireButton
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.backgroundColor = .secondarySystemBackground
      stackView.addSubview(labelYear)
        stackView.addSubview(labelOccupation)
        stackView.addSubview(labelName)
        stackView.addSubview(labelLastName)
        stackView.addSubview(labelCountry)
        stackView.addSubview(yearTextField)
        stackView.addSubview(occupationTextField)
        stackView.addSubview(nameTextField)
        stackView.addSubview(lastNameTextField)
        stackView.addSubview(countryTextField)
        stackView.addSubview(urlSessionButton)
        stackView.addSubview(alamofireButton)
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        view.addSubview(stackView)
        setupConstraints()
        yearTextField.delegate = self
        alamofireButton.addTarget(self,
                     action: #selector(didTapAlamofireButton),
                     for: .touchUpInside)
        urlSessionButton.addTarget(self,
                     action: #selector(didTapUrlSessionButton),
                     for: .touchUpInside)
        onEndEditing(sender: yearTextField)
        onEndEditing(sender: occupationTextField)
        onEndEditing(sender: nameTextField)
        onEndEditing(sender: lastNameTextField)
        onEndEditing(sender: countryTextField)
    }
    private func setNavBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.backgroundColor = Constants.Colors.primaryTeal
        navigationController?.navigationBar.topItem!.title = "Опросник"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor:UIColor.white,
        NSAttributedString.Key.font:UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)]
    }
    func onEndEditing(sender: UITextField) {
        yearInt = 0
        occupationString = sender.text ?? ""
        nameString = sender.text ?? ""
        lastnameString = sender.text ?? ""
        countryString = sender.text ?? ""
    }
    @objc func didTapAlamofireButton(_ sender: Any) {
        guard yearTextField.text?.isEmpty == false &&
                occupationTextField.text?.isEmpty == false &&
                nameTextField.text?.isEmpty == false &&
                lastNameTextField.text?.isEmpty == false &&
                countryTextField.text?.isEmpty == false
        else {
            self.displayFailure()
            return
        }
        sendRequestWithAlamofire()
    }
    func sendRequestWithAlamofire() {
        let yearTextFieldInt: Int? = Int(yearTextField.text!)
        let item = Item(
            birth: yearTextFieldInt!,
            occupation: occupationTextField.text!,
            name: nameTextField.text!,
            lastname: lastNameTextField.text!,
            country: countryTextField.text!)
        AF.request(
            "https://jsonplaceholder.typicode.com/posts",
            method: .post,
            parameters: item,
            encoder: JSONParameterEncoder.default
        ) .response { [weak self] response in
            guard response.error == nil else {
                self?.displayFailure()
                return
            }
            self?.displaySuccess()
            debugPrint(response)
    }
    }
    func displaySuccess() {
        stackView.backgroundColor = .green
       let alertSuccess = UIAlertController(
           title: "Завявка заполнена успешно",
           message: "Хотите заполнить заново?",
           preferredStyle: .alert
        )
      alertSuccess.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
       alertSuccess.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alertSuccess, animated: true)
    }
    func displayFailure() {
        stackView.backgroundColor = .red
        let alertFailure = UIAlertController(
            title: "Ошибка в заполнении",
            message: "Хотите попробовать еще раз?",
            preferredStyle: .alert
        )
        alertFailure.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
        alertFailure.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alertFailure, animated: true)
    }
    @objc func didTapUrlSessionButton(_ sender: Any) {
        guard yearTextField.text?.isEmpty == false &&
                occupationTextField.text?.isEmpty == false &&
                nameTextField.text?.isEmpty == false &&
                lastNameTextField.text?.isEmpty == false &&
                countryTextField.text?.isEmpty == false
        else {
            self.displayFailure()
            return
        }
        sendRequestWithSession()
    }
    func sendRequestWithSession() {
        let yearTextFieldInt: Int? = Int(yearTextField.text!)
        let model1 = Json4Swift_Base(
            birth: yearTextFieldInt!,
            occupation: occupationTextField.text!,
            name: nameTextField.text!,
            lastname: lastNameTextField.text!,
            country: countryTextField.text!)
    let jsonData = try? JSONSerialization.data(
        withJSONObject: [
            model1.dictionaryRepresentation()
        ]
    )
    var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
        guard let data = data, error == nil else {
            DispatchQueue.main.async {
                self?.displayFailure()
            }
            return
        }
        DispatchQueue.main.async {
            self?.displaySuccess()
        }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }.resume()
}
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.height.equalTo(713)
            make.width.equalTo(375)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        labelName.snp.makeConstraints { make in
           make.height.equalTo(50)
           make.width.equalTo(100)
           make.leading.equalTo(stackView.snp.leading).offset(37)
           make.top.equalTo(stackView.snp.top).offset(160)
    }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(203)
     }
        labelLastName.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.top.equalTo(stackView.snp.top).offset(260)
     }
        lastNameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(303)
     }
        labelOccupation.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.top.equalTo(stackView.snp.top).offset(360)
     }
        occupationTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(403)
     }
        labelCountry.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.top.equalTo(stackView.snp.top).offset(460)
     }
        countryTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(503)
     }
        labelYear.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.top.equalTo(stackView.snp.top).offset(560)
     }
        yearTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(603)
     }
        urlSessionButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.leading.equalTo(stackView.snp.leading).offset(37)
            make.trailing.equalTo(stackView.snp.trailing).offset(-200)
            make.top.equalTo(stackView.snp.top).offset(660)
     }
        alamofireButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.leading.equalTo(stackView.snp.leading).offset(200)
            make.trailing.equalTo(stackView.snp.trailing).offset(-38)
            make.top.equalTo(stackView.snp.top).offset(660)
     }
}
    func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
    let allowedCharacters = CharacterSet.decimalDigits
    let characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
}
}
