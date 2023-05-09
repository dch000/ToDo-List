import Foundation
import UserNotifications
import UIKit

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.setValue(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

//Добавление
func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name" : nameItem, "isCompleted" : false])
    setBadge()
}

//Удаление
func removeItem(at index: Int) {
    toDoItems.remove(at: index)
    setBadge()
    
}

//Меняем состояние дела - Выполнено / Не выполнено
//получаем значение и даем ему противоположное состояние
func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return toDoItems[item]["isCompleted"] as! Bool
}

func moveItem(fromIndex: Int, toIndex : Int) {
    let from = toDoItems[fromIndex]
    toDoItems.remove(at: fromIndex)
    toDoItems.insert(from, at: toIndex)
}

// Запрос на отображение количества невыполненных дел
func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("Согласие есть")
        } else {
            print("Отказ")
        }
    }
}

//Установка бэйджа
func setBadge() {
    var totalBadgeNumber = 0
    for item in toDoItems {
        if item["isCompleted"] as? Bool  == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    //Установка бэйджа на иконку
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
    
}
