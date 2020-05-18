//
//  MovieUITableViewController.swift
//  Tutorial5
//
//  Created by Sunny on 27/4/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit
var raffles = [Raffle]()

class RaffleUITableViewController: UITableViewController
{

   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        raffles = database.selectAllRaffle()
         
        
        
      
        
        
    }
    override func viewWillAppear(_ animated: Bool)
       {
           
        let _ : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
           self.tableView.reloadData()
       }

    // MARK: - Table view data source

    override func numberOfSections(in thistable: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return raffles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaffleUITableViewCell", for: indexPath)

        // Configure the cell...
        let raffle = raffles[indexPath.row]
        if let raffleCell = cell as? RaffleUITableViewCell
        {
            raffleCell.rTitleLabel.text = raffle.title
            raffleCell.rPriceLabel.text = String(raffle.price)
            
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowRaffleDetailSegue"
        {
            guard let detailViewController = segue.destination as? DetailViewController else
            {
                fatalError("unexpected destination: \(segue.destination)")
            }
            guard let selectedRaffleCell = sender as? RaffleUITableViewCell else
            {
                fatalError("Unexpected sender: \(String(describing:sender))")
            }
            guard let indexPath = tableView.indexPath (for: selectedRaffleCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedRaffle = raffles[indexPath.row]
            detailViewController.raffle = selectedRaffle
            }
        if segue.identifier == "addNewRaffle"
                  {self.tableView.reloadData()}
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            raffles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        
        }
        
   
//        else if editingStyle == .insert {
//             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        
        
    }
    
    @IBAction func addNewRaffle(segue: UIStoryboardSegue){
        print ("Second view controller closed")
       
               
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        raffles = database.selectAllRaffle()
               self.tableView.reloadData()
       
     
        print("table reload")
        
    }

    
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         //Return false if you do not want the specified item to be editable.
//        return true
//    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
