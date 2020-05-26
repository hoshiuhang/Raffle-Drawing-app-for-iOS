//
//  raffleEditingViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 26/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class raffleEditingViewController: UIViewController {
     @IBOutlet weak var editTitleField: UITextField!
    @IBOutlet weak var editDescriptionField: UITextView!
      
    
    
    
var raffle: Raffle? //store the selected Raffle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Im here")
        if let displayRaffle = raffle
        {
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
            let newRaffle = database.selectRaffleBy(id: displayRaffle.ID)
            editTitleField.text = newRaffle?.title
            editDescriptionField.text = newRaffle?.description
            print("this is \(String(describing: newRaffle?.title))")
            print("this is \(String(describing: newRaffle?.description))")
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
