//
//  AccountsViewController.swift
//  Demo
//
//  Created by Ben Vickers on 13/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit


class AccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var totalsavingsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Set the table background as the image
        tableview1.backgroundColor = UIColor(red: 234/255.0, green: 101/255.0, blue: 51/255.0, alpha: 1.0)
        tableview2.backgroundColor = UIColor(red: 234/255.0, green: 101/255.0, blue: 51/255.0, alpha: 1.0)
       
        //Use the edit button item provided by the table view controller
       // navigationItem.leftBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem = self.editButtonItem;

        
        //Calculate the latest total standings
        BudgetDataModel.calculateTotalStandings()
        totalLabel.text = ("Total Current Amount = £\(BudgetDataModel.returnTrueValue(number: BudgetDataModel.total))")
        
        //Calculate the latest total savings
        SavingsDataModel.calculateSavingsTotal()
        totalsavingsLabel.text = ("Total Savings Amount = £\(BudgetDataModel.returnTrueValue(number: SavingsDataModel.savingstotal))")
        
        self.tableview1.delegate = self
        self.tableview2.delegate = self
        self.tableview1.dataSource = self
        self.tableview2.dataSource = self
        self.tableview2.isHidden = false
        self.tableview1.isHidden = false
        
       // self.tableview.reloadData()
     //   self.tableview2.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        tableview1.reloadData()
        tableview2.reloadData()
    }

    // MARK: - Table view data source
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

  /*  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        //reload data
        
        var label = UILabel()
        
        if (tableView == self.tableview1){
            label.textColor = UIColor.white
            label.text = "Current Accounts"
            return label.text
        //return "Budgets"
        }
        else{
            label.textColor = UIColor.white
            label.text = "Savings"
            return label.text
            //return "Savings"
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowCount = 0
        if (tableView == self.tableview1) {
            rowCount = BudgetDataModel.budgets.count
        }
        if (tableView == self.tableview2) {
            rowCount = SavingsDataModel.savings.count
        }
        return rowCount
        
        
        // #warning Incomplete implementation, return the number of rows
}
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //Table view cells are reused and should be dequeued using a cell identifier.

        if (tableView == self.tableview1){
            let cellIdentifier = "AccountsTableViewCell"
            let cell = self.tableview1.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountsTableViewCell

            let budget = BudgetDataModel.budgets[(indexPath as NSIndexPath).row]
            
            cell.nameLabel.text = budget.name
            cell.amountLabel.text = ("£\(BudgetDataModel.returnTrueValue(number: budget.amount))")
            cell.backgroundColor = UIColor(red: 243.0/255.0, green: 144.0/255.0, blue: 47.0/255.0, alpha: 0.5)
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
            return cell
        }
        else {
        //(tableView == self.tableview2)
            let cellIdentifier2 = "SavingsTableViewCell"
            let cell = self.tableview2.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! SavingsTableViewCell
            
            let saving = SavingsDataModel.savings[(indexPath as NSIndexPath).row]
            
            cell.savingsnameLabel.text = saving.savingname
            cell.savingsamountLabel.text = ("£\(BudgetDataModel.returnTrueValue(number: saving.savingamount))")
            cell.backgroundColor = UIColor(red: 243.0/255.0, green: 144.0/255.0, blue: 47.0/255.0, alpha: 0.5)
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
            return cell
         }
        //return cell
    }
       /* else { preconditionFailure ("unexpected cell type") }
    }*/
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (tableView == self.tableview1){
                // Delete the row from the data source
                BudgetDataModel.budgets.remove(at: indexPath.row)
                BudgetDataModel.saveBudgets()
                BudgetDataModel.calculateTotalStandings()
                totalLabel.text = ("Total Current Amount = £\(BudgetDataModel.returnTrueValue(number:BudgetDataModel.total))")
                tableView.deleteRows(at: [indexPath], with: .fade)

            }
            else if (tableView == self.tableview2){
                // Delete the row from the data source
                SavingsDataModel.savings.remove(at: indexPath.row)
                SavingsDataModel.saveSavings()
                SavingsDataModel.calculateSavingsTotal()
                totalsavingsLabel.text = ("Total Savings Amount = £\(BudgetDataModel.returnTrueValue(number: SavingsDataModel.savingstotal))")
                tableView.deleteRows(at: [indexPath], with: .fade)

            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

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
            if let selectedBudgetCell = sender as? AccountsTableViewCell {
                let indexPath = tableview1.indexPath(for: selectedBudgetCell)!
                let selectedBudget = BudgetDataModel.budgets[indexPath.row]
                budgetDetailViewController.budget = selectedBudget
            }
        }
        else if segue.identifier == "AddItem"{
            //self.tableview.reloadData()
            print("Adding new budget.")
        }
        else if segue.identifier == "ShowSavings"{
                let savingDetailViewController = segue.destination as! SavingsViewController
                //Get the cell that generated this segue.
                if let selectedSavingsCell = sender as? SavingsTableViewCell {
                    let indexPath = tableview2.indexPath(for: selectedSavingsCell)!
                    let selectedSavings = SavingsDataModel.savings[indexPath.row]
                    savingDetailViewController.saving = selectedSavings
                }
        }
        else if segue.identifier == "AddSaving"{
            //self.tableview2.reloadData()
            print ("Adding new saving.")
        }
    }
    
    //MARK: Actions
    
    //Saving the budgets entered
    @IBAction func unwindToBudgetList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? BudgetViewController, let budget = sourceViewController.budget {
            if let selectedIndexPath = tableview1.indexPathForSelectedRow{
                //Update an existing budget.
                BudgetDataModel.budgets[selectedIndexPath.row] = budget
                self.tableview1.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                    //Add a new budget
                    let newIndexPath = IndexPath(row:BudgetDataModel.budgets.count, section: 0)
                    BudgetDataModel.budgets.append(budget)
                    self.tableview1.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                
                    //Add an alert for saving the current account
                   /* let alertController = UIAlertController(title: "Your P&L", message:
                    "Current Account Added!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)*/

                }
            //Save the budgets.
            BudgetDataModel.saveBudgets()
            BudgetDataModel.calculateTotalStandings()
            totalLabel.text = ("Total Current Amount = £\(BudgetDataModel.returnTrueValue(number: BudgetDataModel.total))")

        }
    }
    
    //Saving the savings entered
    @IBAction func unwindtoSavingsList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? SavingsViewController, let savings = sourceViewController.saving {
            if let selectedIndexPath = tableview2.indexPathForSelectedRow{
                //Update an existing budget.
                SavingsDataModel.savings[selectedIndexPath.row] = savings
                self.tableview2.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                //Add a new saving
                let newIndexPath = IndexPath(row:SavingsDataModel.savings.count, section: 0)
                SavingsDataModel.savings.append(savings)
                self.tableview2.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                
                //Add an alert for saving the saving account
                /*let alertController = UIAlertController(title: "Your P&L", message:
                    "Saving Added!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)*/
            }
            //Save the budgets.
            SavingsDataModel.saveSavings()
            SavingsDataModel.calculateSavingsTotal()
            totalsavingsLabel.text = ("Total Savings Amount = £\(BudgetDataModel.returnTrueValue(number: SavingsDataModel.savingstotal))")
            
        }
    }
    
    //Saving the expenses entered
    /*@IBAction func unwindToExpenseList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ExpensesViewController, let expense = sourceViewController.expense
        {
            if let selectedIndexPath = expensesTable.indexPathForSelectedRow{
                //Update an existing budget.
                ExpensesDataModel.expenses[selectedIndexPath.row] = expense
                self.expensesTable.reloadRows(at: [selectedIndexPath], with: .none)
        }
        else{
                //Add a new expense
                let newIndexPath = IndexPath(row:ExpensesDataModel.expenses.count, section: 0)
                ExpensesDataModel.expenses.append(expense)
                self.expensesTable.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
        //Save the expenses.
        ExpensesDataModel.saveExpenses()
        //BudgetDataModel.calculateTotalStandings()
        //totalLabel.text = ("Total Current Amount = £\(BudgetDataModel.returnTrueValue(number: BudgetDataModel.total))")
     }
     }*/
     

    
}
