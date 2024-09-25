//
//  StorageManager.swift
//  ToDoRealm5
//
//  Created by Egor Ukolov on 09.09.2024.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(taskLists: TaskList) {
        write {
            realm.add(taskLists)
        }
    }
    
    func save(task: Task, into taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    func delete(taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    private func write(_ completion: () -> Void) {
        
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
        
    }
    
}
