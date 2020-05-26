//
//  RaffleEditingViewController2.swift
//  Raffle_drawing
//
//  Created by Sunny on 27/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class RaffleEditingViewController2: UIViewController {

//    Interface element
    
    
    @IBOutlet weak var titleField: UITextField!
    
//    Price adjust
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBAction func stepper(_ sender: UIStepper) {
    }
    
    
    
//  Adjusting Max ticket
    @IBOutlet weak var maxTicketLabel: UILabel!
    
    
    @IBAction func slider(_ sender: UISlider) {
    }
    
    
    
    @IBOutlet weak var descriptionField: UITextField!
    
    
    @IBOutlet weak var prizeField: UITextField!
    
    
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBAction func winnerStepper(_ sender: UIStepper) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
