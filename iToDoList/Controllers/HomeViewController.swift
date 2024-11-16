//
//  ViewController.swift
//  iToDoList
//
//  Created by user on 25/08/24.
//

import UIKit

class HomeViewController: UIViewController {

  private let tableView: UITableView = {
    $0.register(UITableViewCell.self,
                forCellReuseIdentifier: "cell")
    return $0
  }(UITableView(frame: .zero, style: .insetGrouped))

  private let searchController = UISearchController()

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNavigation()
  }

  private func setupViews() {
    view.backgroundColor = .secondarySystemGroupedBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupNavigation() {
    navigationItem.title = "My Notes"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = false
    searchController.searchBar.delegate = self
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
}

// MARK: - Table View Setups
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .systemBackground
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

  }
  
}

extension HomeViewController: UISearchBarDelegate {

}
