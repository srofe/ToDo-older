//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Simon Rofe on 16/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit

enum Section: Int {
    case toDo
    case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

    var itemManager: ItemManager?

    // MARK:- UITableViewDataSource compliance

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else { fatalError() }

        switch itemSection {
        case .toDo:
            return itemManager.toDoCount
        case .done:
            return itemManager.doneCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }

        var item: ToDoItem
        switch section {
        case .toDo:
            item = itemManager.item(at: indexPath.row)
        case .done:
            item = itemManager.doneItem(at: indexPath.row)
        }
        cell.configCell(with: item)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // MARK:- UITableViewDelegate compliance

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Check"
    }
}
