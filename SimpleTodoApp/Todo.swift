//
//  Todo.swift
//  SimpleTodoApp
//
//  Created by 谷井朝美 on 2018-07-04.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

import Foundation
import CoreData

@objc(Todo)
class Todo: NSManagedObject {
    
    func setupProperties(title: String, todoDescription: String, priority: Int, isCompleted : Bool) {
        self.title = title
        self.todoDescription = todoDescription
        self.priority = Int32(priority)
        self.isCompleted = isCompleted
    }
}
