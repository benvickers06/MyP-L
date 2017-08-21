//
//  ExpendituresTableViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 06/04/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

class ExpendituresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var expensesTable: UITableView!
    @IBOutlet weak var expensestotalLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Calculate the latest total savings
        ExpensesDataModel.calculateExpensesTotal()
        expensestotalLabel.text = ("Total Expenses Amount = £\(BudgetDataModel.returnTrueValue(number: ExpensesDataModel.expensestotal))")


        self.expensesTable.delegate = self
        self.expensesTable.dataSource = self
        self.expensesTable.isHidden = false
    
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool)
    {
        expensesTable.reloadData()
    }

    // MARK: - Table view data source


    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowCount = 0
        if (tableView == self.expensesTable)
        {
            rowCount = ExpensesDataModel.expenses.count
        }
        return rowCount
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    //Table view cells are reused and should be dequeued using a cell identifier.
    
        if (tableView == self.expensesTable)
        {
            //sort the below
            let cellIdentifier = "ExpensesTableViewCell"
            let cell = self.expensesTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExpensesTableViewCell
        
            let expense = ExpensesDataModel.expenses[(indexPath as NSIndexPath).row]
        
            //sort the below
            cell.expensenameLabel.text = expense.expensename
            cell.expenseamountLabel.text = ("£\(BudgetDataModel.returnTrueValue(number: expense.expenseamount))")
            cell.expensedateLabel.text = expense.expensedate
            cell.backgroundColor = UIColor(red: 243.0/255.0, green: 144.0/255.0, blue: 47.0/255.0, alpha: 0.5)
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
            return cell
        }
        else { preconditionFailure ("unexpected cell type") }
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            if (tableView == self.expensesTable)
            {
                // Delete the row from the data source
                ExpensesDataModel.expenses.remove(at: indexPath.row)
                ExpensesDataModel.saveExpenses()
                ExpensesDataModel.calculateExpensesTotal()
                expensestotalLabel.text = ("Total Expenses Amount = £\(BudgetDataModel.returnTrueValue(number: ExpensesDataModel.expensestotal))")
                tableView.deleteRows(at: [indexPath], with: .fade)
            
            }
        }
        else
        {
            //editingStyle == .insert
                //{
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                //}
        }

    }

        // Override to support rearranging the table view.
        func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
        {
    
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
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "ShowExpenses"
            {
                let expenseDetailViewController = segue.destination as! ExpensesViewController
                //Get the cell that generated this segue.
                if let selectedExpenseCell = sender as? ExpensesTableViewCell
                {
                    let indexPath = expensesTable.indexPath(for: selectedExpenseCell)!
                    let selectedExpense = ExpensesDataModel.expenses[indexPath.row]
                    expenseDetailViewController.expense = selectedExpense
                }
            }
            else if segue.identifier == "AddExpense"
            {
                //self.tableview.reloadData()
                print("Adding new expense.")
            }
        }
    
        //MARK: Actions

        //Saving the expenses entered
        @IBAction func unwindToExpenseList(sender: UIStoryboardSegue)
        {
            if let sourceViewController = sender.source as? ExpensesViewController, let expense = sourceViewController.expense
            {
                if let selectedIndexPath = expensesTable.indexPathForSelectedRow
                {
                    //Update an existing budget.
                    ExpensesDataModel.expenses[selectedIndexPath.row] = expense
                    self.expensesTable.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else
                {
                    //Add a new expense
                    let newIndexPath = IndexPath(row:ExpensesDataModel.expenses.count, section: 0)
                    ExpensesDataModel.expenses.append(expense)
                    self.expensesTable.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                }
                //Save the expenses.
                ExpensesDataModel.saveExpenses()
                ExpensesDataModel.calculateExpensesTotal()
                expensestotalLabel.text = ("Total Expenses Amount = £\(BudgetDataModel.returnTrueValue(number: ExpensesDataModel.expensestotal))")
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
