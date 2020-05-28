//
//  winnerTableViewCell.swift
//  Raffle_drawing
//
//  Created by Sunny on 28/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class winnersTableViewCell: UITableViewCell {

    
    

    
    @IBOutlet weak var ticketIDLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    

    @IBOutlet weak var playerEmailLabel: UILabel!
    
    
    @IBOutlet weak var playerContactLabel: UILabel!
    
    
    
    @IBOutlet weak var ticketPriceLabel: UILabel!
    
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
