//
//  EmployeesViewController.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 06.05.2022.
//
// swiftlint: disable: function_body_length
// swiftlint: disable: type_body_length
import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    var yearInt: Int = 0
    var occupationString: String = ""
    var nameString: String = ""
    var lastnameString: String = ""
    var countryString: String = ""
    private let labelYear: UILabel = {
        let labelYear = UILabel()
        labelYear.numberOfLines = 0
        labelYear.font = .systemFont(ofSize: 14, weight: .semibold)
        labelYear.text = "Дата рождения"
        return labelYear
    }()
    private let labelOccupation: UILabel = {
        let labelOcupation = UILabel()
        labelOcupation.numberOfLines = 0
        labelOcupation.font = .systemFont(ofSize: 14, weight: .semibold)
        labelOcupation.text = "Должность"
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
        yearTextField.placeholder = "Введите дату рождения"
        yearTextField.font = UIFont.systemFont(ofSize: 14)
        yearTextField.borderStyle = UITextField.BorderStyle.roundedRect
        yearTextField.autocorrectionType = UITextAutocorrectionType.no
        yearTextField.keyboardType = UIKeyboardType.default
        yearTextField.returnKeyType = UIReturnKeyType.done
        yearTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        yearTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return yearTextField
    }()
    private let occupationTextField: UITextField = {
    let occupationTextField =  UITextField()
        occupationTextField.placeholder = "Введите должность"
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
        nameTextField.placeholder = "Введите имя"
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
        lastNameTextField.placeholder = "Введите фамилию"
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
        countryTextField.placeholder = "Введите страну"
        countryTextField.font = UIFont.systemFont(ofSize: 14)
        countryTextField.borderStyle = UITextField.BorderStyle.roundedRect
        countryTextField.autocorrectionType = UITextAutocorrectionType.no
        countryTextField.keyboardType = UIKeyboardType.default
        countryTextField.returnKeyType = UIReturnKeyType.done
        countryTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        countryTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return countryTextField
    }()
    var employee: Employee?
    private let addNewEmployee: UIButton = {
        let alamofireButton = UIButton()
        alamofireButton.subtitleLabel?.numberOfLines = 0
        alamofireButton.setTitle("Отправить", for: .normal)
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
        stackView.addSubview(addNewEmployee)
        return stackView
    }()
override func viewDidLoad() {
super.viewDidLoad()
title = "Личные данные"
    navigationController?.navigationBar.backgroundColor = Constants.Colors.primaryTeal
view.addSubview(stackView)
setupConstraints()
    yearTextField.delegate = self
    addNewEmployee.addTarget(self,
                     action: #selector(didTapAddEmployee),
                     for: .touchUpInside)
    if let employee = employee {
        nameTextField.text = employee.name
        lastNameTextField.text = employee.lastname
        occupationTextField.text = employee.occupation
        countryTextField.text = employee.country
        yearTextField.text = employee.birth
    }
    }
    @objc func didTapAddEmployee(_ sender: Any) {
        employee?.name = nameTextField.text
        employee?.lastname = lastNameTextField.text
        employee?.occupation = occupationTextField.text
        employee?.country = countryTextField.text
        employee?.birth = yearTextField.text
        try? employee?.managedObjectContext?.save()
        navigationController?.popViewController(animated: true)
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
        addNewEmployee.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.leading.equalTo(stackView.snp.leading).offset(119)
            make.trailing.equalTo(stackView.snp.trailing).offset(-119)
            make.top.equalTo(stackView.snp.top).offset(660)
     }
}
}
