//
//  ticketTableViewCell2.swift
//  Raffle_drawing
//
//  Created by Sunny on 26/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit





class ticketTableViewCell2: UITableViewCell {

    @IBOutlet weak var ticket_id: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    
    
    @IBOutlet weak var ticketPrice: UILabel!
    
    
    @IBOutlet weak var dateTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
