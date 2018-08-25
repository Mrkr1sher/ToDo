//
//  TableViewController.swift
//  Todoey
//
//  Created by Krish Thawani on 8/20/18.
//  Copyright © 2018 Innocent Penguin. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    var categoriesArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        tableView.rowHeight = 80
    }
    
    
    
//MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoriesArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 1
    }
    
    
    
//MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoriesArray?[indexPath.row]
        }
        
    }
    
    
    
//MARK: - Add New Categories
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertAddAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(save: newCategory)
            
        }
        alert.addTextField { (field) in
            textField.placeholder = "Create New Item"
            textField = field
            
        }
        alert.addAction(alertCancelAction)
        alert.addAction(alertAddAction)
        present(alert, animated: true, completion: nil)
        
        print(categoriesArray!)
        print(realm.objects(Category.self))
    }
    
    
    
//MARK: - Data Manipulation Methods
    
    //Save
    func save(save: Category) {
        do {
            try realm.write {
                realm.add(save)
            }
        } catch {
            print("Problem saving to Realm \(error)")
        }
        tableView.reloadData()
        
    }
    
    //Load
    func loadCategories() {
        categoriesArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //Delete
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = categoriesArray?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryToDelete)
                }
            } catch {
                print("Error trying to delete data from Swipe \(error)")
            }
        }
    }
}
