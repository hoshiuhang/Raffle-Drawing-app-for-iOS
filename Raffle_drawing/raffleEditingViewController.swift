//
//  RaffleEditingViewController2.swift
//  Raffle_drawing
//
//  Created by Sunny on 27/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class raffleEditingViewController: UIViewController {
//  create raffle variable ti stroe current raffle information
    
    var raffle: Raffle? //store the selected Raffle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let displayRaffle = raffle
           {
           let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
           
            let newRaffle = database.selectRaffleBy(id: displayRaffle.ID) //get the latest raffle information
           
            titleField.text = newRaffle?.title
           
            descriptionField.text = newRaffle?.description
            
            let currentPrice:Int32 = newRaffle!.price
            priceLabel.text = String(currentPrice)
            priceStepperOutlet.value = Double(currentPrice)
            
            let currentMax:Int32 = newRaffle!.max_ticket
            maxTicketLabel.text = String(currentMax)
            maxTicketOutlet.value = Float(currentMax)
            
            
            prizeField.text = newRaffle?.prize
            
            let currentWinnerNo:Int32 = newRaffle!.winnerNo
            winnerLabel.text = String(currentWinnerNo)
            winnerStepperOutlet.value = Double(currentWinnerNo)
        
            
           print("this is \(String(describing: newRaffle?.title))")
           print("this is \(String(describing: newRaffle?.description))")
            print("this is winnerno\(String(describing: newRaffle?.winnerNo))")
           }
        
        
        
        
            priceStepperOutlet.wraps = true
            priceStepperOutlet.autorepeat = true
            priceStepperOutlet.stepValue = 1
            priceStepperOutlet.minimumValue = 1
            priceStepperOutlet.maximumValue = 100

    
            winnerStepperOutlet.wraps = true
            winnerStepperOutlet.autorepeat = true
            winnerStepperOutlet.stepValue = 1
            winnerStepperOutlet.minimumValue = 1
            winnerStepperOutlet.maximumValue = 100
    }
    
    
//    Interface element
    
    @IBOutlet weak var titleField: UITextField!
//    Price adjust
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceStepperOutlet: UIStepper!
    
    @IBAction func priceStepperControl(_ sender: UIStepper) {
        
        priceLabel.text = Int32(sender.value).description
        
        print("this is the current stepper value \(priceStepperOutlet.value)")
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
//    confrim btn
    
    @IBAction func updateBtn(_ sender: UIButton) {
        let raffleName = raffle?.ID
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
      let selectedRaffle = database.selectRaffleBy(id: raffleName!)
      let selectedRaffleStates = selectedRaffle?.status
      print("this is rafflestatus \(String(describing: selectedRaffleStates))")
      if selectedRaffleStates == 0
      {
        confirmUpdate()
        self.performSegue(withIdentifier: "finishEditingSegue", sender: self)
    
      }
        else
      {
        let alert = UIAlertController(title: "ALert", message: "This raffle has started/drew, detail cannot be change", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func confirmUpdate()
    {
        if var displayRaffle = raffle
        {
            displayRaffle.title = String(titleField.text ?? "Not Provided")
            displayRaffle.description = String(descriptionField.text ?? "Not Provided")
            displayRaffle.price = Int32(String(priceLabel.text!)) ?? 1
            displayRaffle.max_ticket = Int32(String(maxTicketLabel.text!)) ?? 100
            displayRaffle.prize = String(prizeField.text ?? "Not Provided")
            displayRaffle.winnerNo = Int32(String(winnerLabel.text!)) ?? 1
            
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
            database.editingRaffleDetailBy(raffle: displayRaffle)
        }
        
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
