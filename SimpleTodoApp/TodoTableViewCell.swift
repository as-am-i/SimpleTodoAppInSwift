//
//  TodoTableViewCell.swift
//  SimpleTodoApp
//
//  Created by 谷井朝美 on 2018-07-09.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

import UIKit



class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    func update(with todo: Todo) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.todoDescription
        priorityLabel.text = "Priority: \(todo.priority)"
        
        if (todo.isCompleted) {
            addStrikethrough(with: todo.title!, on: titleLabel)
            addStrikethrough(with: todo.todoDescription!, on: descriptionLabel)
            addStrikethrough(with: "Priority: \(todo.priority)", on: priorityLabel)
        }
    }
    
    func addStrikethrough(with string: String, on uiLabel: UILabel) {
        let attributeString = NSMutableAttributedString(string: string)
        attributeString.addAttributes([NSAttributedStringKey.strikethroughStyle : 2], range: NSMakeRange(0, attributeString.length))
        uiLabel.attributedText = attributeString
    }
}
