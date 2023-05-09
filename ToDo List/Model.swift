import Foundation

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
}

//Удаление
func removeItem(at index: Int) {
    toDoItems.remove(at: index)
    
}

//Меняем состояние дела - Выполнено / Не выполнено
//получаем значение и даем ему противоположное состояние
func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    return toDoItems[item]["isCompleted"] as! Bool
}
