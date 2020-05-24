//
//  CreateRaffleViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 3/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class CreateRaffleViewController: UIViewController
{
    
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet var maxPlayerField: UITextField!
    
    @IBOutlet var prizeField: UITextField!
    
    //Price input
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceStepper: UIStepper!
    @IBAction func priceStepperAction(_ sender: UIStepper) {
        priceLabel.text = Int(sender.value).description
    }
    
    //Max Ticket input
    @IBOutlet weak var maxTicketLabel: UILabel!
    @IBOutlet weak var maxTicketSlider: UISlider!
    @IBAction func maxTicketSliderAction(_ sender: UISlider) {
         let currentValue = Int(sender.value)
            maxTicketLabel.text = "\(currentValue)"
    }
    
    
    
    
    
    
    
    var myraffleUItableViewController: RaffleUITableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        priceStepper.wraps = false
        priceStepper.autorepeat = true
        priceStepper.maximumValue = 100
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   


    @IBAction func confirmButton(_ sender: Any)
    
    {
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        let raffleTitle:String = (titleField.text!)
        let rafflePrice:Int? = Int(priceLabel.text!)
        let maxTicket:Int? = Int(maxTicketLabel.text!)
        let maxPlayer:Int32? = Int32(maxPlayerField.text!)
        let prizeTitle:String = prizeField.text!


        database.insert(raffle:Raffle (title:String(raffleTitle ), price:Int32(rafflePrice ?? 5), max_ticket:Int32(maxTicket ?? 1000),max_player:Int32(maxPlayer ?? 100),prize:String(prizeTitle )))
        myraffleUItableViewController?.viewWillAppear(true)
        
    self.performSegue(withIdentifier: "addNewRaffle", sender:self)
     
    }

}

