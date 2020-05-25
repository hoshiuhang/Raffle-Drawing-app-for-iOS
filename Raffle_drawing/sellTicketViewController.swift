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
            calculateTotal()
    }
    
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        no_of_ticketLabel.text = Int(sender.value).description
        
        
        
    }
    @IBOutlet weak var singleTicketPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
    
        
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
                self.printMessage()
                print("currentTicket\(currentTicket)")
                self.performSegue(withIdentifier: "completeSale", sender: self)//go back to perious screen
                //call the sale function
                
               }))
        self.present(alert, animated: true, completion: nil)
        
    }//end of the calculate function
    
    func printMessage(){
    
    
    print ("test1")
    
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
