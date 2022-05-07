//
//  MovieCell.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 05.05.2022.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
 static let identifier = "MovieCell"
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
       return imageView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addSubview(movieTitle)
        stackView.addSubview(movieDescription)
        stackView.addSubview(movieImage)
        return stackView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.translatesAutoresizingMaskIntoConstraints = false
         contentView.addSubview(stackView)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    var cellViewModel: MovieCellViewModel? {
        didSet {
            movieTitle.text = cellViewModel?.title
            movieDescription.text = cellViewModel?.description
            if let url = cellViewModel?.image {
                 URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                     guard let data = data, error == nil else {
                         return
                     }
                     DispatchQueue.main.async {
                         self?.movieImage.image = UIImage(data: data)
                     }
                 } .resume()
             }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = nil
        movieDescription.text = nil
        movieImage.image = nil
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.height.equalTo(113)
            make.width.equalTo(375)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        movieTitle.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.width.equalTo(57)
            make.leading.equalTo(stackView.snp.leading).offset(82)
            make.trailing.equalTo(stackView.snp.trailing).offset(-36)
            make.top.equalTo(stackView.snp.top).offset(26)
            make.bottom.equalTo(stackView.snp.bottom).offset(-68)
    }
        movieDescription.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(269)
            make.leading.equalTo(movieTitle.snp.leading)
            make.trailing.equalTo(stackView.snp.trailing).offset(-14)
            make.top.equalTo(stackView.snp.top).offset(53)
            make.bottom.equalTo(stackView.snp.bottom).offset(-18)
            make.top.equalTo(movieTitle.snp.bottom).offset(8)
    }
        movieImage.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(50)
            make.leading.equalTo(stackView.snp.leading).offset(16)
            make.trailing.equalTo(stackView.snp.trailing).offset(-309)
            make.top.equalTo(stackView.snp.top).offset(16)
            make.bottom.equalTo(stackView.snp.bottom).offset(-27)
            make.trailing.equalTo(movieTitle.snp.leading).offset(-16)
            make.trailing.equalTo(movieDescription.snp.leading).offset(-16)
          }
    }
}
