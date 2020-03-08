//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  var toDoArray = ["wash clothes", "mua sm stuff", "watch netflix series"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let leftButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: Selector("showEditing:"))
    self.navigationItem.leftBarButtonItem = leftButton
    leftButton.tintColor = .white
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    cell.textLabel?.text = toDoArray[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(toDoArray[indexPath.row])
    
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  @IBAction func addToDo(_ sender: UIBarButtonItem?) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Item",
                                  message: "",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      if let text = textField.text {
        if text == "" {
          self.showAlert(message: "There nothing to add")
        } else {
          self.toDoArray.append(text)
        }
      } else {
        self.showAlert(message: "Add item failed, please try again")
      }
      self.tableView.reloadData()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Enter your item"
      textField = alertTextField
    }
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func showAlert(message: String) {
    let alertController = UIAlertController(title: "Error", message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
    
    self.present(alertController, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      toDoArray.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      addToDo(nil)
    }
  }
  
  @objc func showEditing(_ sender: UIBarButtonItem)
  {
    if(self.tableView.isEditing == true)
    {
      self.tableView.isEditing = false
      self.navigationItem.rightBarButtonItem?.title = "Done"
    }
    else
    {
      self.tableView.isEditing = true
      self.navigationItem.rightBarButtonItem?.title = "Edit"
    }
  }
  
  
}

