//
//  popupViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 25/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class addPlayerViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //controll
   
    @IBOutlet weak var nameField: UITextField!
    
   
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var mobileField: UITextField!
    @IBAction func ConfirmBtn(_ sender: UIButton) {
    
        var playerName:String? = nil
        playerName = (nameField.text!)
        
       
        
        if (playerName ?? "").isEmpty
        {
            
            let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                   NSLog("The \"OK\" alert occured.")
                   }))
                   self.present(alert, animated: true, completion: nil)
        print("Nothing to see here")

        }
        else
        {
        let playerEmail:String = (emailField.text!)
        let playerMobile:Int = Int(mobileField.text!) ?? 0
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
       
        
        database.insertPlayer(player:Player(fname:String(playerName!),contact_no:Int32(Int(playerMobile)),email:String(playerEmail)))
        
        print("add one player")
        
            self.performSegue(withIdentifier: "addNewPlayer", sender:self)
            
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
