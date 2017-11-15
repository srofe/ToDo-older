//
//  ItemManager.swift
//  ToDo
//
//  Created by Simon Rofe on 16/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import Foundation

class ItemManager {
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }

    func add(item newItem: ToDoItem) {
        toDoItems.append(newItem)
    }

    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }

    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }

    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
}
