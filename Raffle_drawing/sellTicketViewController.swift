//
//  sellTicketViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 24/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

var raffle: Raffle?//collect Raffle related detail
class sellTicketViewController: UIViewController {

//   on screen display and contol area
    //Player information control
    @IBAction func searchUserBtn(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
    
    //selling ticket control
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet var no_of_ticketLabel: UILabel!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        no_of_ticketLabel.text = Int(sender.value).description
    }
    @IBOutlet weak var singleTicketPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
    
        
        
        
        // Do any additional setup after loading the view.
    }
//    private var singleTicketPrice = Int(singleTicketPriceLabel.text!)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
