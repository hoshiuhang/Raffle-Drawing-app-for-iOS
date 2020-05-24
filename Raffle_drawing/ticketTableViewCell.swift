//
//  ticketTableViewCell.swift
//  Raffle_drawing
//
//  Created by Sunny on 18/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class ticketTableViewCell: UITableViewCell {

    
    @IBOutlet var tNumberLabel: UILabel!
    
    @IBOutlet var playerNameLabel: UILabel!
    
    @IBOutlet var tPriceLabel: UILabel!
    
    @IBOutlet var dateTimeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
