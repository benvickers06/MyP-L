//
//  BudgetTableViewController.swift
//  Demo
//
//  Created by Ben Vickers on 13/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit

class BudgetTableViewController: UITableViewController {

    //MARK: Properties
    
    var budgets = [Budget]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Load any saved budgets, otherwise load sample data.
        if let savedBudgets = loadBudgets(){
            budgets += savedBudgets
        }
        else{
            //Load the sample data.
            loadSampleBudgets()
        }

    }

    func loadSampleBudgets(){
        
        let photo1 = UIImage(named: "budget1")!
        let budget1 = Budget(name: "Rent", photo: photo1)!
        
        let photo2 = UIImage(named: "budget2")!
        let budget2 = Budget(name: "Bills", photo: photo2)!
        
        let photo3 = UIImage(named: "budget3")!
        let budget3 = Budget(name: "Groceries", photo: photo3)!
        
        budgets += [budget1, budget2, budget3]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return budgets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BudgetTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BudgetTableViewCell
        
        let budget = budgets[(indexPath as NSIndexPath).row]

        cell.nameLabel.text = budget.name
        cell.photoImageView.image = budget.photo
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            budgets.remove(at: indexPath.row)
            saveBudgets()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            let budgetDetailViewController = segue.destination as! BudgetViewController
            //Get the cell that generated this segue.
            if let selectedBudgetCell = sender as? BudgetTableViewCell {
                let indexPath = tableView.indexPath(for: selectedBudgetCell)!
                let selectedBudget = budgets[indexPath.row]
                budgetDetailViewController.budget = selectedBudget
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding new budget.")
        
        }
    }
    
    
    @IBAction func unwindToBudgetList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? BudgetViewController, let budget = sourceViewController.budget {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing budget.
                budgets[selectedIndexPath.row] = budget
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                    //Add a new meal
                    let newIndexPath = IndexPath(row:budgets.count, section: 0)
                    budgets.append(budget)
                    tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                }
            //Save the budgets.
            saveBudgets()
            }
    }
    
    //MARK: NSCoding
    
    func saveBudgets(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(budgets, toFile: Budget.ArchiveURL.path)
        
        if !isSuccessfulSave {
            print("Failed to save budgets...")
        }
    }
    
    func loadBudgets() -> [Budget]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Budget.ArchiveURL.path) as? [Budget]
    }
}

