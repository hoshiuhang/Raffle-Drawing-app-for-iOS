//
//  ticketDetailViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 29/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class ticketDetailViewController: UIViewController {

    var ticket: Ticket?
    var raffle: Raffle?
    
    @IBOutlet weak var playerName: UITextField!
    
    
    @IBOutlet weak var playerEmail: UITextField!
    
    
    @IBOutlet weak var playerContact: UITextField!
    
    @IBOutlet weak var ticketPriceLabel: UILabel!
    
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    @IBOutlet weak var ticketIDLabel: UILabel!
    
    
    
    @IBAction func updateBtn(_ sender: UIButton) {
        let testResult = inputValidation()
        if testResult == true
        {
         let alert = UIAlertController(title: "Do You want to update the ticket detail ?", message: "If You want to update ticket detail, Please click 'Confirm'", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
                   NSLog("The \"cancel\" alert occured.")}))

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                       NSLog("Confirm update.")//log message
                       self.updateTicket()
                       self.performSegue(withIdentifier: "updateTicketDetailCompleteSegue", sender: self)//go back to perious screen
                       //call the sale function
                       
                      }))
               self.present(alert, animated: true, completion: nil)
        
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentTicket = ticket
        playerName.text = currentTicket?.playerName
        playerEmail.text = currentTicket?.playerEmail
        let playerContactNo:Int32 = currentTicket?.playerContact ?? 0
        if playerContactNo == 0
        {
            playerContact.text = ""
        }
        else{
        playerContact.text = String(playerContactNo)
        }
        let currentTicketPrice:Int32 = currentTicket!.tPrice
        ticketPriceLabel.text = String(currentTicketPrice)
        dateTimeLabel.text = currentTicket?.dateTime
        let currentTicketID:Int32 = currentTicket!.ticketID
        ticketIDLabel.text = String(currentTicketID)
        // Do any additional setup after loading the view.
        
    }
    func updateTicket()
    {
        var selectedTicket = ticket
        selectedTicket?.playerName = String(playerName.text!)
        selectedTicket?.playerEmail = String(playerEmail.text!)
        selectedTicket?.playerContact = Int32(String(playerContact.text!)) ?? 0
        
        let raffleID:Int32 = raffle!.ID
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        database.updateTicketDetailBy(raffleID: raffleID, ticket:selectedTicket!)
    }
     func inputValidation()->Bool
        {
            var inputTest:Bool = true
            
            let currentPlayerName:String = (playerName.text!)
            
            let currentEmail:String = String(playerEmail.text!)
            let emailTest:Bool = currentEmail.isEmpty
            var emailFormatTest:Bool = true
            
            let currentContact = String(playerContact!.text!)
            let contactTest:Bool = currentContact.isEmpty
            var contactFormatTest:Bool = true
                       
            print ("this is user name \(currentPlayerName)")
            print ("this is user email \(currentEmail)")
            print ("this is user contact \(currentContact)")
                   // name test
            if currentPlayerName.isEmpty
            {
                inputTest = false
                let alert = UIAlertController(title: "Missing Player Name", message: "Need a player Name for the ticket.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                //test if at least one contact information provided
                if emailTest && contactTest
                {
                    print("Fail Contact information test")
                    inputTest = false
                    
                    let alert = UIAlertController(title: "Missing Contact Information", message: "Please Provide at least One contact information", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                //if at least one or both provided
                else
                {
                    // if player provide contact no
                    if contactTest == false
                   {
                    //test the input
                      contactFormatTest = currentContact.isValidPhone
                      print("This is the contact no  test result \(contactFormatTest)")
                    //alert if the input fail
                        if contactFormatTest == false
                        {
                            inputTest = false
                            let alert = UIAlertController(title: "Phone no. provided is not valid", message: "Please Provide 10 digit Australia Phone no", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    // if user provided email
                    if emailTest == false
                    {
    //                    test the email formate
                        emailFormatTest = currentEmail.isValidEmail
                        print("Has email input")
                        print("This is the email provide \(currentEmail)")
                        print("This is the email format test result \(emailFormatTest)")
                        // if the test false alert
                        if emailFormatTest == false
                        {
                            inputTest = false
                        let alert = UIAlertController(title: "Email provided is not valid", message: "Please Provide a validate emaill address", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
                        self.present(alert, animated: true, completion: nil)
                        }
                    }
                   }//end of contact information test
                }
            return inputTest
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
