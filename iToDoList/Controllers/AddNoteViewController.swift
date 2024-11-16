//
//  DetailViewController.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit

protocol ListNotesDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}

class AddNoteViewController: UIViewController {

  private lazy var textView: UITextView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .light)
    $0.textColor = .label
    return $0
  }(UITextView())

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setConstrains()
  }

  private func setupViews() {
    view.addSubview(textView)
    navigationController?.navigationBar.prefersLargeTitles = false
  }

  override func viewDidAppear(_ animated: Bool) {
    textView.becomeFirstResponder()
  }
}

// MARK: - Constrains
extension AddNoteViewController {
  private func setConstrains() {
    NSLayoutConstraint.activate([
      textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textView.leftAnchor.constraint(equalTo: view.leftAnchor),
      textView.rightAnchor.constraint(equalTo: view.rightAnchor),
      textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
