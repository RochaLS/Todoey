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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadItems()
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
        saveItems()
    
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
            
           self.saveItems()
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
    
    //MARK - Model manipulation methods
    
    // Encoding Item array to a plist
    func saveItems() {
        let enconder = PropertyListEncoder()
        
        do {
            let data = try enconder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // Decoding the Item array from the plist
    func loadItems() {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding Item array, \(error)")
                
            }
        }
    }
}

