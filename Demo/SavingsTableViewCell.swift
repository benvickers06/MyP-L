//
//  SavingsTableViewCell.swift
//  My P&L
//
//  Created by Ben Vickers on 20/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

class SavingsTableViewCell: UITableViewCell {

    @IBOutlet weak var savingsnameLabel: UILabel!
    @IBOutlet weak var savingsamountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
