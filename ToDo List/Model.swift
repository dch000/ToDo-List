import Foundation

var toDoItems: [[String: Any]] = [["Name": "Позвонить маме", "isCompleted" : true],["Name": "Заказать пиццу", "isCompleted" : false]]

//Добавление
func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name" : nameItem, "isCompleted" : false])
    saveData()
}

//Удаление
func removeItem(at index: Int) {
    toDoItems.remove(at: index)
    saveData()
}

//Сохранение данных
func saveData() {}

//Загрузка данных
func loadData() {}

//Меняем состояние дела - Выполнено / Не выполнено
//получаем значение и даем ему противоположное состояние
func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    saveData()
    return toDoItems[item]["isCompleted"] as! Bool
}
