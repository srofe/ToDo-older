//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Simon Rofe on 16/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: ItemListDataProvider!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataProvider
    }
}
