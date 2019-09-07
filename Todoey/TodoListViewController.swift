//
//  ViewController.swift
//  Todoey
//
//  Created by Ming Wen on 9/6/19.
//  Copyright © 2019 ginmnew. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = Array<String>()
    
    let defaults = UserDefaults.standard
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var item = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { _ in
            self.itemArray.append(item.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Creat new item"
            item = alertTextFiled
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: "listItemCell")
        
        if let bug = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = bug
        }
        
    }
    
    //MARK: Tableview Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as! ListItemTableViewCell
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as! ListItemTableViewCell
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        
    }

}

