//
//  RaffleEditingViewController2.swift
//  Raffle_drawing
//
//  Created by Sunny on 27/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class RaffleEditingViewController2: UIViewController {
//  create raffle variable ti stroe current raffle information
    var raffle: Raffle? //store the selected Raffle
//    Interface element
    @IBOutlet weak var titleField: UITextField!
//    Price adjust
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceStepperOutlet: UIStepper!
    
    @IBAction func priceStepperControl(_ sender: UIStepper) {
        priceLabel.text = Int32(sender.value).description
    }
    
    
    
//  Adjusting Max ticket
    @IBOutlet weak var maxTicketLabel: UILabel!

   
    @IBOutlet weak var maxTicketOutlet: UISlider!
    
    
    @IBAction func maxTicketSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        maxTicketLabel.text = "\(currentValue)"
    }
    
    @IBOutlet weak var descriptionField: UITextField!
  
    @IBOutlet weak var prizeField: UITextField!
    
//  number of winner
    @IBOutlet weak var winnerLabel: UILabel!

    @IBOutlet weak var winnerStepperOutlet: UIStepper!
    
    @IBAction func winnerStepperControl(_ sender: UIStepper) {
        winnerLabel.text = Int32(sender.value).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    priceStepperOutlet.wraps = true
    priceStepperOutlet.autorepeat = true
    priceStepperOutlet.minimumValue = 1
    priceStepperOutlet.maximumValue = 100

    
    winnerStepperOutlet.wraps = true
    winnerStepperOutlet.autorepeat = true
    winnerStepperOutlet.minimumValue = 1
    winnerStepperOutlet.maximumValue = 100
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
