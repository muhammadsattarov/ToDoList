//
//  HomeTableViewCell.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
static let reuseId = "HomeTableViewCell"
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 17, weight: .medium)
    $0.textColor = .label
    return $0
  }(UILabel())

  private lazy var descriptionLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 15, weight: .regular)
    $0.textColor = .secondaryLabel
    return $0
  }(UILabel())

  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    setConstrains()
  }

  private func setup() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.backgroundColor = .tertiarySystemBackground
  }

  func configure(with model: Note) {
    titleLabel.text = model.title
    descriptionLabel.text = model.desc
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Constrains
extension HomeTableViewCell {
  private func setConstrains() {
    NSLayoutConstraint.activate([
      titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),

      descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
      descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
    ])
  }
}
