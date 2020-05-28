//
//  sellTicketViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 24/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit



class sellTicketViewController: UIViewController {

var raffle: Raffle?//collect Raffle related detail
    
    // on screen display and contol area
    //Player information control
    @IBAction func searchUserBtn(_ sender: UIButton) {
        
    }
    

    @IBOutlet weak var playerNameField: UITextField!
    
    
    @IBOutlet weak var userEmailField: UITextField!
    
    
    @IBOutlet weak var userMobileField: UITextField!
    
   
    
    
    
    
    
    //selling ticket control
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet var no_of_ticketLabel: UILabel!
    
    
    @IBAction func totalPriceBtn(_ sender: UIButton) {
        let currentContact = String(userMobileField.text ?? "0")
        let contactTest = currentContact.isValidPhone
        print(contactTest)
        if contactTest == true || currentContact == "0"
        {
        calculateTotal()
        }
        else
        {
            let alert = UIAlertController(title: "Input error", message: "Please enter 10 digit Australia phone number", preferredStyle: .alert)

                   alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
                       NSLog("The \"cancel\" alert occured.")}))
                   self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        no_of_ticketLabel.text = Int(sender.value).description
        
        
        
    }
    @IBOutlet weak var singleTicketPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = 1
        stepper.maximumValue = 100
    
        
         if let displayRaffle = raffle
               {
                   singleTicketPriceLabel.text = String(displayRaffle.price)
               }
        
        
        // Do any additional setup after loading the view.
    }
    
    //calculat the total
    var currentticket = ""
    var singleTicketPrice = ""
    
    func calculateTotal()
    {
        let currentRaffle = raffle
        let currentTicket:Int = Int(no_of_ticketLabel.text!) ?? 0
        let singleTickePrice:Int = Int(currentRaffle!.price)
        let totalPrice = singleTickePrice * currentTicket
        
        
        
        let alert = UIAlertController(title: "Total $\(totalPrice) for \(currentTicket) ticket(s)", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"cancel\" alert occured.")}))

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("Confirm sales.")//log message
                self.sellticket()
                print("currentTicket\(currentTicket)")
                self.performSegue(withIdentifier: "completeSale", sender: self)//go back to perious screen
                //call the sale function
                
               }))
        self.present(alert, animated: true, completion: nil)
        
    }//end of the calculate function
    
   
    //insert ticket function
    func sellticket(){
        //draw out raffle detail
        let currentRaffle = raffle //use this view raffle id
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        let raffle2 = database.selectRaffleBy(id:currentRaffle!.ID )//get the updated data from database
        
        print("this iscurrent ticket sold\(String(describing: raffle2?.ticketSold))")
        let raffle_id:Int32 = raffle2!.ID
        print("this iscurrent id\(String(describing: raffle2?.ID))")
        var ticketSold:Int32 = raffle2!.ticketSold
        var max_ticket:Int32 = raffle2!.max_ticket
        let ticketPrice:Int32 = Int32(singleTicketPriceLabel.text!)!
        let playerName:String = playerNameField.text!
        let playerEmail:String = userEmailField.text ?? "not provide"
        let playerContact:Int32 = Int32(userMobileField.text!) ?? 0
        var totalTicketSold:Int = Int(no_of_ticketLabel.text!) ?? 1
        //get the current time
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        let purchaseTime = formatter.string(from: currentDateTime)
        
        let i = 0
        while i<totalTicketSold
        {
        
            database.insertTicket(raffleTitle:raffle_id,ticket:Ticket(tPrice:Int32(ticketPrice),playerName:playerName,playerEmail:playerEmail,playerContact:playerContact,dateTime:purchaseTime,status:0))
           ticketSold+=1
            max_ticket-=1
        database.updateRaffleBy(id: raffle_id, status: 1,ticketSold:ticketSold,max_ticket:max_ticket)
            totalTicketSold-=1
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
