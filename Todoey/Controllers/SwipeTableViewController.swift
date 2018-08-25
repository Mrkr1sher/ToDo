//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Krish Thawani on 8/25/18.
//  Copyright © 2018 Innocent Penguin. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift


class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell : UITableViewCell?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
// MARK: - Swipeable Methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    
//MARK: - Data Manipulation Methods
    
    // Save
//    func save(save: String) {
//        do {
//            try realm.write {
//                realm.add(save)
//            }
//        } catch {
//            print("Problem saving to Realm \(error)")
//        }
//        tableView.reloadData()
//    }
    
    
    
    
    
// MARK: - Custom Methods
    
    func updateModel(at indexPath: IndexPath) {
        
    }
}


