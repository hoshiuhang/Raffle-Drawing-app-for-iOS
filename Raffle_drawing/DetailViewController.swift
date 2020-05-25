//
//  DetailViewController.swift
//  Tutorial5
//
//  Created by Sunny on 27/4/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var tickets = [Ticket]()//store ticket detail
    var raffle: Raffle? //store the selected Raffle
    
    
    
    
  
    
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
    
   //Ticket table
    @IBOutlet weak var ticketView: UITableView!
    
    //table cell label
    
   
    
    
    
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
        //connect to database
            
        
         let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(tableName:String(rTitleLabel.text! ))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ticketTableViewCell", for: indexPath)

          // Configure the cell...
          let ticket = tickets[indexPath.row]
          if let ticketCell = cell as? ticketTableViewCell
          {
              ticketCell.tNumberLabel.text = String(ticket.ticketID)
              ticketCell.playerNameLabel.text = ticket.playerName
              ticketCell.tPriceLabel.text = rPriceLabel.text
              ticketCell.dateTimeLabel.text = ticket.dateTime
          }

          return cell
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
    @IBAction func completeSale(segue: UIStoryboardSegue) {
        print("complete sale")
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


