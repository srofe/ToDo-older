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

    func addItem(_ item: ToDoItem) {
        toDoCount += 1
    }
}
