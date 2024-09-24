//
//  Task.swift
//  ToDoRealm5
//
//  Created by Egor Ukolov on 09.09.2024.
//

import RealmSwift

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}

class TaskList: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    var tasks = List<Task>()
}
  
