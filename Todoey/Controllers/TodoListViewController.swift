//
//  ViewController.swift
//  Todoey
//
//  Created by Lucas Rocha on 2019-07-24.
//  Copyright © 2019 Lucas Rocha. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        let newItem = Item()
        newItem.title = "Be rich!"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Finish this app!"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Go to Spain!"
        itemArray.append(newItem3)
    }
    
    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
        // Inserting content from the itemArray on the cells
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            
        let item = itemArray[indexPath.row]
            
        cell.textLabel?.text = item.title
            //Same thing as a if statement but shorter and better
            // value = condition ? value if true : value if false
            cell.accessoryType = item.done ? .checkmark : .none
            
//            if item.done == true {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
        
        return cell
    }
    
    //MARK - Table delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If Item is selected the state property will change from the actual state to the opposite state
        // if it's true it will be false and if it's false it will be true
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            // This will happen after user pressed Add Item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        //Adding textfield to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        // Add action to the alert
        alert.addAction(alertAction)
        
        // Shows the alert
        present(alert, animated: true, completion: nil)
    }
}

