//
//  AccountsTableViewCell.swift
//  Demo
//
//  Created by Ben Vickers on 13/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
