//
//  Model.swift
//  ToDoList(Practice)
//
//  Created by Vakhtang on 29.12.2022.
//

import Foundation
import UserNotifications
import UIKit

var todoList: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDateKey")
        UserDefaults.standard.synchronize()    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDateKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
    
}

func addItem (nameItem: String, isCompleted: Bool = false) {
    todoList.append(["Name": nameItem, "IsCompleted": isCompleted])
    setBadge()
}

func moveItem(fromIndex: Int, toIndex: Int){
    
    let from = todoList[fromIndex]
    todoList.remove(at: fromIndex)
    todoList.insert(from, at: toIndex)
    
}

func removeItem(at index: Int) {
    todoList.remove(at: index)
    setBadge()
}

func changeState(at item: Int) -> Bool {
    todoList[item]["IsCompleted"] = !(todoList[item]["IsCompleted"] as! Bool)
    
    setBadge()
    return todoList[item]["IsCompleted"] as! Bool
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        
    }
}

func setBadge() {
    var totalBadgeNumber = 0
    for item in todoList {
        if (item["IsCompleted"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
