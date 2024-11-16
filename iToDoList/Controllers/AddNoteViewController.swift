//
//  DetailViewController.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit

protocol AddNoteViewControllerDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}


class AddNoteViewController: UIViewController {

  private lazy var textView: UITextView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 18, weight: .regular)
    $0.textColor = .label
    $0.delegate = self
    return $0
  }(UITextView())

  var note: Note!
  weak var delegate: AddNoteViewControllerDelegate?

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setConstrains()
  }

  private func setupViews() {
    view.backgroundColor = .systemBackground
    view.addSubview(textView)
    navigationController?.navigationBar.prefersLargeTitles = false
    textView.text = note.text
  }

  override func viewDidAppear(_ animated: Bool) {
    textView.becomeFirstResponder()
  }

  private func updateNote() {
    note.lastUpdated = Date()
    CoreDataManager.shared.save()
    delegate?.refreshNotes()
  }

  private func deleteNote() {
    delegate?.deleteNote(with: note.id)
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

// MARK: - UITextViewDelegate
extension AddNoteViewController: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    note.text = textView.text
    if note.title.isEmpty {
      deleteNote()
    } else {
      updateNote()
    }
  }
}
