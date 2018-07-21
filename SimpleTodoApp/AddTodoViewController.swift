//
//  AddTodoViewController.swift
//  SimpleTodoApp
//
//  Created by 谷井朝美 on 2018-07-11.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

import UIKit
import CoreData

// add todo with delegate
protocol AddTodoViewControllerDelegate: class {
    
    func addTodo(_ todo: Todo)
}

class AddTodoViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var todoTitleTextField: UITextField!
    @IBOutlet weak var todoDescriptionTextView: UITextView!
    @IBOutlet weak var todoPriorityTextField: UITextField!
    @IBOutlet weak var saveTodoButton: UIBarButtonItem!
    @IBOutlet weak var todoIsFinishedSwitch: UISwitch!
    
    var managedObjectContext: NSManagedObjectContext!
    
    weak var delegate: AddTodoViewControllerDelegate?
    weak var todo: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoTitleTextField.delegate = self
        self.todoDescriptionTextView.delegate = self
        self.todoPriorityTextField.delegate = self
        
        self.todoTitleTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFields()
        updateSaveButtonState()
    }
    
    // MARK: private methods
    private func setupFields() {
        if todo != nil {
            todoTitleTextField.text = todo?.title
            todoDescriptionTextView.text = todo?.todoDescription
            todoPriorityTextField.text = "\(todo?.priority ?? 0)"
            todoIsFinishedSwitch.isOn = (todo?.isCompleted)!
        }
    }
    
    @IBAction private func createTodo(_ sender: UIBarButtonItem) {
        let title = todoTitleTextField.text
        let todoDescription = todoDescriptionTextView.text
        let priority = todoPriorityTextField.text
        let isCompleted = todoIsFinishedSwitch.isOn
        
        if !(title?.isEmpty)! && !(todoDescription?.isEmpty)! && !(priority?.isEmpty)! {
            // ! at the end of each condition is for unwrap
            if todo == nil {
                todo = Todo(context: managedObjectContext)
            }
            
            var priorityInt = 0;
            if Int(priority!) != nil {
                priorityInt = Int(priority!)!
            }
            
            todo?.setupProperties(title: title!, todoDescription: todoDescription!, priority: priorityInt, isCompleted: isCompleted)
            
            self.delegate?.addTodo(todo!)
        }
        
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    private func updateSaveButtonState() {
        let title = todoTitleTextField.text ?? "" // ?? is nil coalescing operator
        let todoDescription = todoDescriptionTextView.text ?? ""
        let priority = todoPriorityTextField.text ?? ""
        
        saveTodoButton.isEnabled = !title.isEmpty && !todoDescription.isEmpty && !priority.isEmpty
    }
}

extension AddTodoViewController: UITextFieldDelegate, UITextViewDelegate {
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            // Go to next textfield
            nextField.becomeFirstResponder()
        }
        else {
            // Last textfield
            textField.resignFirstResponder()
            todoPriorityTextField.becomeFirstResponder()
        }
        
        updateSaveButtonState()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: UITextViewDelegate
    // UITextView is the bigger text field
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            updateSaveButtonState()
            
            return false
        }
        return true
    }
}
