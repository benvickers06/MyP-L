//
//  ExpensesTableViewCell.swift
//  My P&L
//
//  Created by Ben Vickers on 06/04/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

class ExpensesTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var expensenameLabel: UILabel!
    @IBOutlet weak var expenseamountLabel: UILabel!
    @IBOutlet weak var expensedateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
