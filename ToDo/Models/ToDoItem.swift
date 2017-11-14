//
//  ToDoItem.swift
//  ToDo
//
//  Created by Simon Rofe on 15/11/17.
//  Copyright © 2017 Simon Rofe. All rights reserved.
//

import Foundation

struct ToDoItem {
    let title: String
    let description: String?

    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}
