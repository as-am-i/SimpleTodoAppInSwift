//
//  ViewController.swift
//  SimpleTodoApp
//
//  Created by 谷井朝美 on 2018-07-04.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    
    var todos = [Todo]()
    
    func setupTodos() {
//        let todo = Todo(context: managedObjectContext)
//        todo.setupProperties(title: "sleep well", todoDescription: "go to bed, relax the body, and close the eyes", priority: 1, isCompleted: false)
//
//        let todo1 = Todo(context: managedObjectContext)   
//        todo1.setupProperties(title: "Eat well", todoDescription: "go to kitchen, get some meals, and feed yourself", priority: 2, isCompleted: false)
        
//        let todo2 = Todo(context: managedObjectContext)
//        todo2.setupProperties(title: "Walk, walk, walk", todoDescription: "take a step forward, and one more step, and another one...", priority: 3, isCompleted: true)
        
        saveContext()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTodos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllTodos()
    }
    
    // MARK: Core Data
    fileprivate func loadAllTodos() {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        do {
            todos = try managedObjectContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    fileprivate func saveContext() {
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    fileprivate func delete(todo: Todo) {
        managedObjectContext.delete(todo)
        saveContext()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: animated)
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTodo" {
            if let destination = segue.destination as? AddTodoViewController {
                destination.delegate = self
                destination.managedObjectContext = self.managedObjectContext
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        let todo = todos[indexPath.row]
        
        cell.update(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            delete(todo: todos[indexPath.row]) // delete for core data
            todos.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController: AddTodoViewControllerDelegate {
    
    func addTodo(_ todo: Todo) {
        saveContext()
    }
}


