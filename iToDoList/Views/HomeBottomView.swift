//
//  HomeBottomView.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit

class HomeBottomView: UIView {
  lazy var addNoteButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    $0.tintColor = .systemOrange
    return $0
  }(UIButton(type: .system))

  lazy var noteCountLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.tintColor = .label
    $0.font = .systemFont(ofSize: 14, weight: .light)
    $0.textAlignment = .center
    $0.text = "36 notes"
    return $0
  }(UILabel())

  private lazy var lineView: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemGray6
    return $0
  }(UIView())

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConstrains()
  }

  private func setup() {
    self.backgroundColor = .tertiarySystemBackground
    self.addSubview(addNoteButton)
    self.addSubview(noteCountLabel)
    self.addSubview(lineView)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

  // MARK: - Constrains
extension HomeBottomView {
  private func setConstrains() {
    NSLayoutConstraint.activate([
      addNoteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
      addNoteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
      addNoteButton.widthAnchor.constraint(equalToConstant: 35),
      addNoteButton.heightAnchor.constraint(equalToConstant: 35),

      noteCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      noteCountLabel.centerYAnchor.constraint(equalTo: addNoteButton.centerYAnchor),

      lineView.topAnchor.constraint(equalTo: self.topAnchor),
      lineView.leftAnchor.constraint(equalTo: self.leftAnchor),
      lineView.rightAnchor.constraint(equalTo: self.rightAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}

