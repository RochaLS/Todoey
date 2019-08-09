//
//  ViewController.swift
//  Todoey
//
//  Created by Lucas Rocha on 2019-07-24.
//  Copyright © 2019 Lucas Rocha. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var items : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //MARK: - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of rows
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
        // Inserting content from the itemArray on the cells
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            
            if let item = items?[indexPath.row] {
                cell.textLabel?.text = item.title
                //Same thing as a if statement but shorter and better
                // value = condition ? value if true : value if false
                cell.accessoryType = item.done ? .checkmark : .none
            } else {
                cell.textLabel?.text = "No items added :("
            }
        
        return cell
    }
    
    //MARK: - Table delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*If Item is selected the state property will change from the actual state to the opposite state
         if it's true it will be false and if it's false it will be true
        */
        
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error updating cell \(error)")
            }
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items

    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            // This will happen after user pressed Add Item
            
            self.saveItems(textField: textField)
            
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
    
    //MARK: - Model Manipulation Methods
    
    // Saving data
    func saveItems(textField: UITextField) {
        if let currentCategory = selectedCategory {
            do {
                try realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
            } catch {
                print("Problems saving new Item \(error)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    

    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
 
        tableView.reloadData()
    }
 
    
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            // Dismissing keyboard on the main thread
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
        }
    }
}

