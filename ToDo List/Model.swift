import Foundation

var toDoItems: [String] = ["Позвонить маме", "Написать приложение"]

//Добавление
func addItem(nameItem: String) {
    toDoItems.append(nameItem)
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
