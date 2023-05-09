

import UIKit

class TableTableViewController: UITableViewController {

    // включаем / отключаем редактирование таблицы
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        // замедление обновления таблицы, для того чтобы анимация успела красиво отработать
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        //создаем Alert Controller
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        // добавляем в него текстовое поле
        alertController.addTextField { (textField) in
            textField.placeholder = "New item name"
        }
        // описываем кнопку "Отмена"
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default)
        {(alert) in }
        // описываем кнопку "Сохранить"
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel)
        {(alert) in
            //Добавить новую запись
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
    
        //добавляем кнопки в Alert Controller
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    //количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

   // генерация ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //вывод в ячеку текста из массива
        //задаем в константу переменную - словарь
        let currentItem = toDoItems[indexPath.row]
        //получаем имя как строку
        cell.textLabel?.text = currentItem["Name"] as? String
        
        //получаем объект из словаря по ключу isCompleted
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "check")
        } else {
            cell.imageView?.image = UIImage(named: "uncheck")
        }
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        }
        
        return cell
    }
    
    //Редактирование ячейки по индексу
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //Нажатие на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //отключаем залипание
        tableView.deselectRow(at: indexPath, animated: true)
        
        //меняем значение
        if changeState(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck")
        }
    }
    
    // Метод меняет записи местами
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        
        tableView.reloadData()
    }
        
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
