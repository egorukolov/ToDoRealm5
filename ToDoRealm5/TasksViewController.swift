//
//  TasksViewController.swift
//  ToDoRealm5
//
//  Created by Egor Ukolov on 20.09.2024.
//

import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var currentList: TaskList!
    
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentList.name
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        currentTasks = currentList.tasks.filter("isComplete = false")
        completedTasks = currentList.tasks.filter("isComplete = true")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT TASKS" : "COMPLETED TASKS"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.note
        
        return cell
    }
    
    @objc private func addButtonPressed() {
        showAlert()
    }

}

extension TasksViewController {
    
    private func showAlert() {
        
        let alert = AlertController(title: "New Task", message: "What do you want to do?", preferredStyle: .alert)
        
        alert.actionWithTask { newValue, note in
            let task = Task(value: [newValue, note])
            StorageManager.shared.save(task: task, into: self.currentList)
            let rowIndex = IndexPath(row: self.currentTasks.count - 1, section: 0)
            self.tableView.reloadRows(at: [rowIndex], with: .automatic)
        }
        
        present(alert, animated: true)
    }
}
