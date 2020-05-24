//
//  DetailViewController.swift
//  Tutorial5
//
//  Created by Sunny on 27/4/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    
    // Display raflle detail label
 
    @IBOutlet var rTitleLabel: UILabel!
    
    @IBOutlet var rPriceLabel: UILabel!
    
    @IBOutlet var rIDLabel: UILabel!
    
    
//    button
    
    
    @IBAction func drawRaffleButton(_ sender: UIButton) {
    }
    
    
    @IBAction func sellTicketButton(_ sender: UIButton) {
    }
    
    
    @IBAction func editingRaffleButton(_ sender: UIButton) {
    }
    
    
    @IBAction func soldTisketListButton(_ sender: UIButton) {
    }
    
    
    
    var raffle: Raffle? //store the selected Raffle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let displayRaffle = raffle
        {
            rTitleLabel.text = displayRaffle.title
            rPriceLabel.text = String(displayRaffle.price)
            rIDLabel.text = String(displayRaffle.ID)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {     if segue.identifier == "showTicketListSegue"
        {         print("Second view controller segue called")
            
            let displayRaffle = raffle //Get the current raffle name
            
            let nextScreen = segue.destination as! ticketTableViewController //select target screen
            
            nextScreen.raffleTitle = String(displayRaffle!.title)
            
        }
        if segue.identifier == "sellTicketSegue"
               {         print("go to sell ticket")
                   
                 guard let sellTicketScreen = segue.destination as? sellTicketViewController else
                 {
                     fatalError("unexpected destination: \(segue.destination)")
                 }
                
                 let selectedRaffle = raffle
                 sellTicketScreen.raffle = selectedRaffle
                 }
               }
    }
   
    //pass the raffle detail to detail view controller
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


