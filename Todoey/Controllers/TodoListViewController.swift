//
//  ViewController.swift
//  Todoey
//
//  Created by Alexander Rabau on 15.05.18.
//  Copyright © 2018 appDevelopment-ar. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    


      var itemArray = [Item]()
    
   // var itemArray : [Item]!

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

      
     
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
        loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
        
//       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items        }
        
      
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        
        // Next line is equal to if else statement but much shorter and nicer
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        

        saveItems()
        

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            
            let newItem = Item(context: self.context)
           
            
           
            newItem.title = textField.text!
            newItem.done = false
            
             self.itemArray.append(newItem)
            
            self.saveItems()
      

        }
        
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
                
        }
        
            alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
        do{
           try context.save()
        } catch {
            print("Error saving context, \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
      itemArray =  try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
}
}

