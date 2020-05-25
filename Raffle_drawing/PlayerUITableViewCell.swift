//
//  PlayerTableViewCell.swift
//  Raffle_drawing
//
//  Created by Sunny on 8/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class PlayerUITableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
