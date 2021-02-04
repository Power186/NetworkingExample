//
//  RewardsTableViewController.swift
//  FetchRewards
//
//  Created by Scott on 2/3/21.
//

import UIKit

class RewardsTableViewController: UITableViewController {
    let networkController = NetworkController()
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    private func fetchItems() {
        networkController.fetchItems { [weak self] (result) in
            switch result {
            case .success(let storeItems):
                DispatchQueue.main.async {
                    let sorted = storeItems.sorted()
                    self?.items = sorted
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configure(cell: ItemTableViewCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.idLabel.text = String(item.id ?? 0)
        cell.listIdLabel.text = String(item.listId ?? 0)
        cell.nameLabel.text = item.name ?? ""
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemTableViewCell
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }

}




