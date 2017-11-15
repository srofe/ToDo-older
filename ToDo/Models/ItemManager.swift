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
    var doneCount = 0
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []

    func add(item newItem: ToDoItem) {
        toDoCount += 1
        toDoItems.append(newItem)
    }

    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }

    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }

    func checkItem(at index: Int) {
        toDoCount -= 1
        doneCount += 1
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
}
