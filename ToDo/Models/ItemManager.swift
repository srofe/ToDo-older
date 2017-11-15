//
//  ItemManager.swift
//  ToDo
//
//  Created by Simon Rofe on 16/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import Foundation

class ItemManager {
    var toDoCount = 0
    let doneCount = 0

    func add(item newItem: ToDoItem) {
        toDoCount += 1
    }

    func item(at index: Int) -> ToDoItem {
        return ToDoItem(title: "Item Name")
    }
}
