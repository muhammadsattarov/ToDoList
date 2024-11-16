//
//  ViewController.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

  private let tableView: UITableView = {
    $0.register(HomeTableViewCell.self,
                forCellReuseIdentifier: HomeTableViewCell.reuseId)
    $0.backgroundColor = .clear
    return $0
  }(UITableView(frame: .zero, style: .insetGrouped))

  private let searchController = UISearchController()
  private let bottomView = HomeBottomView()

  private var fetchResultController: NSFetchedResultsController<Note>!

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNavigation()
    setupBottomView()
    setConstrains()
    setupFetchResultController()
    refreshCoountLabel()
  }

  private func setupViews() {
    view.backgroundColor = .secondarySystemBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupNavigation() {
    navigationItem.title = "My Notes"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .automatic
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = false
    searchController.searchBar.delegate = self
  }

  private func setupBottomView() {
    view.addSubview(bottomView)
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    bottomView.addNoteButton.addTarget(
      self, action: #selector(didTapAddNoteButton),
      for: .touchUpInside
    )
  }

  private func setupFetchResultController(filter: String? = nil) {
    fetchResultController = CoreDataManager.shared.createFetchResultController(filter: filter)
    fetchResultController.delegate = self
    try? fetchResultController.performFetch()
    refreshCoountLabel()
  }

  private func refreshCoountLabel() {
    let count = fetchResultController.sections?[0].numberOfObjects
    if let count {
      bottomView.noteCountLabel.text = "\(count) \(count == 1 ? "Note" : "Notes")"
    } else {
      print("Refresh count error")
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  private func gotoEditNote(_ note: Note) {
    let vc = AddNoteViewController()
    vc.note = note
    navigationController?.pushViewController(vc, animated: true)
  }

  private func createNote() -> Note {
    let note = CoreDataManager.shared.createNote()
    return note
  }

  private func deleteNoteFromStorage(_ note: Note) {
    CoreDataManager.shared.deleteNote(note)
  }

  // MARK: - Actions
  @objc private func didTapAddNoteButton() {
    gotoEditNote(createNote())
  }
}

// MARK: - Table View Setups
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return fetchResultController.sections?.count ?? 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let notes = fetchResultController.sections?[section]
    return notes?.numberOfObjects ?? 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseId, for: indexPath) as! HomeTableViewCell
    let note = fetchResultController.object(at: indexPath)
    cell.configure(with: note)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let note = fetchResultController.object(at: indexPath)
    gotoEditNote(note)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let note = fetchResultController.object(at: indexPath)
      deleteNoteFromStorage(note)
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      search(searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    search("")
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    search(searchBar.text ?? "")
  }

  func search(_ query: String) {
    if query.count >= 1 {
      setupFetchResultController(filter: query)
    } else {
      setupFetchResultController()
    }
    tableView.reloadData()
  }
}

// MARK: - Constrains
extension HomeViewController {
  private func setConstrains() {
    NSLayoutConstraint.activate([
      bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
      bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
      bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomView.heightAnchor.constraint(equalToConstant: 75)
    ])
  }
}

// MARK: - Constrains
extension HomeViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .fade)
    case .move:
      tableView.moveRow(at: indexPath!, to: newIndexPath!)
    case .update:
      tableView.reloadRows(at: [indexPath!], with: .automatic)
    default:
      tableView.reloadData()
    }
    refreshCoountLabel()
  }
}
