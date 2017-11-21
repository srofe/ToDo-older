//
//  ItemCell.swift
//  ToDo
//
//  Created by Simon Rofe on 17/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configCell(with item: ToDoItem) {
        titleLabel.text = item.title
    }

}
